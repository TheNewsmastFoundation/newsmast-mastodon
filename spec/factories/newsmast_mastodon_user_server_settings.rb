# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_user_server_setting, class: "NewsmastMastodon::UserServerSetting" do
    # Both `user_id` and `server_setting` are required; user belongs to the
    # Mastodon host. Specs should mark themselves pending.
    user_id { Faker::Number.unique.number(digits: 8) }
    association :server_setting, factory: :newsmast_mastodon_server_setting
    value { "true" }
  end
end
