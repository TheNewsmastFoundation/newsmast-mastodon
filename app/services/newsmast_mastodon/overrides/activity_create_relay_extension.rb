# frozen_string_literal: true

module NewsmastMastodon
  module Overrides
    # Prepended into ActivityPub::Activity::Create to intercept statuses
    # received via a configured custom relay and add them to a per-domain
    # Redis sorted set (feed:relay:<sanitized_domain>).
    module ActivityCreateRelayExtension
      include Redisable

      RELAY_FEED_MAX_ITEMS = 800

      private

      # Override create_status to hook in after the parent creates the Status
      # record, while still having access to @options[:relayed_through_actor].
      def create_status
        @status = super

        add_to_relay_feed if relay_status?

        @status
      end

      # Returns true only when the status was delivered through one of the
      # ENV-configured custom relay domains.
      def relay_status?
        return false unless @status.present?
        return false unless @options[:relayed_through_actor].present?

        relay_account = @options[:relayed_through_actor]
        relay = Relay.find_by(inbox_url: relay_account.inbox_url)
        return false unless relay&.enabled?

        domain = NewsmastMastodon::CustomRelayConfig.domain_from_inbox_url(relay.inbox_url)
        domain.present? && custom_relay_domains.include?(domain)
      end

      def add_to_relay_feed
        relay_account = @options[:relayed_through_actor]
        domain        = NewsmastMastodon::CustomRelayConfig.domain_from_inbox_url(relay_account.inbox_url)
        return unless domain.present?

        key           = NewsmastMastodon::RelayFeed.timeline_key(domain)

        with_redis do |redis|
          redis.zadd(key, @status.id, @status.id)
          # Trim oldest entries beyond the cap (rank 0 = oldest)
          redis.zremrangebyrank(key, 0, -(RELAY_FEED_MAX_ITEMS + 1))
          # 30-day TTL as a safety net for stale feeds
          redis.expire(key, 30.days.to_i)
        end
      end

      def custom_relay_domains
        NewsmastMastodon::CustomRelayConfig.domains
      end
    end
  end
end
