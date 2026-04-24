# frozen_string_literal: true

module NewsmastMastodon
  class ServerSetting < ApplicationRecord
    self.table_name = 'server_settings'

    # From accounts/posts/local_only_posts
    validates :optional_value, presence: true, allow_nil: true
    # From content_filters
    validates :name, presence: true

    belongs_to :parent, class_name: 'NewsmastMastodon::ServerSetting', optional: true
    has_many :children, class_name: 'NewsmastMastodon::ServerSetting', foreign_key: 'parent_id'

    # From content_filters
    has_many :user_server_settings, class_name: 'NewsmastMastodon::UserServerSetting'
    has_many :users, through: :user_server_settings

    # From posts
    def self.get_long_post(name)
      find_by(name: name)
    end
  end
end
