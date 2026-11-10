# frozen_string_literal: true

# FactoryBot factories for NewsmastMastodon::Community and related traits.
# Factories that depend on Mastodon host models (Account, MediaAttachment)
# reference them by class name; specs must ensure the host is loaded or
# mark themselves pending.

FactoryBot.define do
  factory :newsmast_mastodon_community, class: "NewsmastMastodon::Community" do
    name        { Faker::Lorem.unique.words(number: 2).join(" ").titleize }
    slug        { name.parameterize }
    description { Faker::Lorem.paragraph }
    visibility      { "public" }
    post_visibility { "public" }

    trait :with_logo do
      # Image attachments require ActiveStorage + the host Mastodon app.
      # Specs exercising attachments should mark themselves pending.
    end

    trait :with_admins do
      after(:create) do |community|
        create_list(:newsmast_mastodon_community_admin, 2, community: community)
      end
    end

    trait :broadcast do
      channel_type { "broadcast" }
    end

    trait :group do
      channel_type { "group" }
    end

    trait :custom do
      channel_type { "custom" }
    end
  end
end
