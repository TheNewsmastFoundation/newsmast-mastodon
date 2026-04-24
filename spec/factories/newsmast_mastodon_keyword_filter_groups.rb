# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_keyword_filter_group, class: "NewsmastMastodon::KeywordFilterGroup" do
    sequence(:name) { |n| "filter_group_#{n}" }

    trait :with_keyword_filters do
      after(:create) do |group|
        create_list(:newsmast_mastodon_keyword_filter, 3, keyword_filter_group: group)
      end
    end
  end
end
