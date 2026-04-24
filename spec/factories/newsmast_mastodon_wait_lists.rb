# frozen_string_literal: true

FactoryBot.define do
  factory :newsmast_mastodon_wait_list, class: "NewsmastMastodon::WaitList" do
    email           { Faker::Internet.unique.email }
    invitation_code { SecureRandom.hex(4) }
    channel_type    { "broadcast" }
  end
end
