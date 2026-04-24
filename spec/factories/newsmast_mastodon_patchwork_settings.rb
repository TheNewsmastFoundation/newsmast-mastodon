# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_patchwork_setting, class: "NewsmastMastodon::PatchworkSetting" do
    account_id { Faker::Number.unique.number(digits: 8) }
    app_name   { "patchwork" }
    settings   { {} }

    trait :patchwork do app_name { "patchwork" } end
    trait :newsmast  do app_name { "newsmast" } end
    trait :channel   do app_name { "channel" } end
  end
end
