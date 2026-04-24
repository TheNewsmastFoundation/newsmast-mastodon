# frozen_string_literal: true

# Merged from:
#   accounts/app/models/accounts/concerns/account_concern.rb (notification_tokens, patchwork_settings)
#   content_filters/app/models/content_filters/concerns/account_concern.rb (followed_tags, without_banned, channel_admins, domain federation helpers)
#   posts/app/models/posts/concerns/account_concern.rb (patchwork_drafted_statuses)
#   timelines_extension/app/models/timelines_extension/concerns/account_concern.rb (followed_tags — duplicate, kept once)
module NewsmastMastodon
  module Concerns
    module AccountConcern
      extend ActiveSupport::Concern

      included do
        has_many :notification_tokens,
                 class_name: 'NewsmastMastodon::NotificationToken',
                 dependent: :delete_all,
                 inverse_of: :account

        has_many :patchwork_settings,
                 class_name: 'NewsmastMastodon::PatchworkSetting',
                 foreign_key: :account_id,
                 dependent: :destroy

        has_many :patchwork_drafted_statuses,
                 inverse_of: :account,
                 dependent: :destroy,
                 class_name: 'NewsmastMastodon::DraftedStatus'

        # Tag follows (via TagFollow model) — followed tags convenience association.
        # Declared in both content_filters and timelines_extension — keep ONCE to avoid ArgumentError.
        has_many :followed_tags, through: :tag_follows, source: :tag

        scope :without_banned,  -> { where(accounts: { is_banned: false }) }
        scope :channel_admins, ->(value) { where(id: value) }

        def excluded_domain_by_server_setting_federation
          user = User.find_by(account_id: id)
          Rails.cache.fetch("filter_account_ids_by_server_setting_federation:#{id}") do
            Account.where(domain: user.get_server_setting_exclude_domains).pluck(:id)
          end
        end

        def follow_account?(target_account_id)
          Follow.exists?(account_id: self&.id, target_account_id: target_account_id)
        end
      end
    end
  end
end
