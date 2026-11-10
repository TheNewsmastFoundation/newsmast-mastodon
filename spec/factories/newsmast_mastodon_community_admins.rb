# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_community_admin, class: "NewsmastMastodon::CommunityAdmin" do
    community
    # `account` belongs to the Mastodon host `Account` model. Specs that use
    # this factory must either stub account association or mark themselves
    # pending via the "requires Mastodon host" shared example.
    account_id { Faker::Number.unique.number(digits: 8) }

    trait :active     do account_status { "active" } end
    trait :suspended  do account_status { "suspended" } end
    trait :deleted    do account_status { "deleted" } end
  end
end
