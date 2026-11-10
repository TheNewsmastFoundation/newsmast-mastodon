# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_notification_token, class: "NewsmastMastodon::NotificationToken" do
    account_id        { Faker::Number.unique.number(digits: 8) }
    platform_type     { "ios" }
    notification_token { SecureRandom.hex(32) }
  end
end
