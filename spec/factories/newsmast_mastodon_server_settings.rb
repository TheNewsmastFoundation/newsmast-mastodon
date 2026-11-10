# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_server_setting, class: "NewsmastMastodon::ServerSetting" do
    sequence(:name) { |n| "setting_#{n}" }
    value          { "default" }
    optional_value { nil }

    trait :with_parent do
      parent { association(:newsmast_mastodon_server_setting) }
    end

    trait :with_children do
      after(:create) do |parent|
        create_list(:newsmast_mastodon_server_setting, 2, parent: parent)
      end
    end

    trait :long_post do
      name  { "long_post_max_characters" }
      value { "5000" }
    end
  end
end
