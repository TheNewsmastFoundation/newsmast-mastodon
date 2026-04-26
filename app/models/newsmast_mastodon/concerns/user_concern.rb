# frozen_string_literal: true

# Merged from:
#   accounts/app/models/concerns/user_concern.rb (after_create callbacks, settings bootstrap)
#   content_filters/app/models/content_filters/concerns/user_concern.rb (get_server_setting_exclude_domains)
module NewsmastMastodon
  module Concerns
    module UserConcern
      extend ActiveSupport::Concern
      include EmailNotificationAttributesConcern
      include PatchworkHelper

      DOMAIN_FILTERS = {
        'Threads': ['threads.social', 'threads.net'].freeze,
        'Bluesky': ['bridgy.fed', 'bluesky.social'].freeze
      }.freeze

      included do
        after_create :create_user_settings, :apply_server_setting_to_account, :set_bluesky_bridge_enable
      end

      def get_server_setting_exclude_domains
        filter_domains = []

        DOMAIN_FILTERS.each do |setting, domains|
          federation = NewsmastMastodon::ServerSetting.where(name: setting.to_s).first
          filter_domains.concat(domains) if federation && federation.value?
        end

        filter_domains
      end

      private

      def create_user_settings
        notification_emails = settings.as_json.select do |key, _|
          key.to_s.start_with?('notification_emails.')
        end

        return if notification_emails.present?

        # Only override host defaults when the env var is explicitly set.
        # Without this guard, every newly created user would get all
        # `notification_emails.*` flags forced to false, masking host defaults
        # (e.g. `report: true`) and breaking specs/admin workflows that rely
        # on them.
        env_value = ENV.fetch('DEFAULT_EMAIL_NOTIFICATIONS_ENABLED', nil)
        return if env_value.nil?

        enabled_notification  = env_value == 'true'
        new_notification_settings = email_notification_attributes(enabled: enabled_notification)
        # Use update_columns-style skip-validations path: assign settings via
        # the virtual accessor and persist with validation disabled so this
        # after_create callback never re-runs (and re-fails) the parent's
        # validations (e.g. when the User was constructed without an email
        # in tests using `User.new(account: ...)`).
        self.settings_attributes = new_notification_settings
        save(validate: false)
      end

      # Configures user searchability and discoverability based on the Dashboard's
      # 'search-opt' ServerSetting.
      #
      # Enabled search-opt:  user becomes hidden from search results (noindex: true).
      # Disabled search-opt: user remains visible and discoverable (noindex: false).
      def apply_server_setting_to_account
        return unless patchwork_server_settings_exist?

        setting = NewsmastMastodon::ServerSetting.find_by(name: 'Automatic Search Opt-out')
        return unless setting.present? && account.present?

        opt_out = ActiveModel::Type::Boolean.new.cast(setting.value)
        account.update(
          discoverable: !opt_out,
          indexable: !opt_out
        )
        update!(settings_attributes: { noindex: opt_out })
      end

      def set_bluesky_bridge_enable
        return unless patchwork_server_settings_exist?
        return unless NewsmastMastodon::ServerSetting.find_by(name: 'Automatic Bluesky bridging for new users')&.value

        update!(bluesky_bridge_enabled: true)
      end
    end
  end
end
