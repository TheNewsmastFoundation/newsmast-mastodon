# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_drafted_status, class: "NewsmastMastodon::DraftedStatus" do
    account_id  { Faker::Number.unique.number(digits: 8) }
    params      { { text: Faker::Lorem.sentence } }

    trait :with_media do
      # Media attachments are host-owned; specs should mark themselves pending.
    end
  end
end
