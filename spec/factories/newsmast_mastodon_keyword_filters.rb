# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_keyword_filter, class: "NewsmastMastodon::KeywordFilter" do
    association :keyword_filter_group, factory: :newsmast_mastodon_keyword_filter_group
    keyword     { Faker::Lorem.unique.word }
    filter_type { "content" }

    trait :content  do filter_type { "content" } end
    trait :hashtag  do filter_type { "hashtag" } end
    trait :both     do filter_type { "both" } end
  end
end
