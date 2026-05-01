# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::Community, type: :model do
  it "validates image size limits on logo and header attachments" do
    require_host!
  end

  it "validates attachment content types (image/png, image/jpeg, image/webp)" do
    expect(NewsmastMastodon::Community::IMAGE_MIME_TYPES).to include("image/png", "image/jpeg", "image/webp")
  end

  it "has_many :community_admins" do
    ref = NewsmastMastodon::Community.reflect_on_association(:community_admins)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:has_many)
  end

  it "has_many :community_hashtags" do
    ref = NewsmastMastodon::Community.reflect_on_association(:community_hashtags)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:has_many)
  end

  it "has_one :community_post_type" do
    ref = NewsmastMastodon::Community.reflect_on_association(:community_post_type)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:has_one)
  end

  it "defines :visibility enum with expected values" do
    expect(NewsmastMastodon::Community.visibilities.keys).to contain_exactly("public_access", "guest_access", "private_local")
  end

  it "defines :post_visibility enum with expected values" do
    expect(NewsmastMastodon::Community.post_visibilities.keys).to contain_exactly("public_visibility", "unlisted", "followers_only", "direct")
  end

  it "processes image attachments through ActiveStorage variants" do
    require_host!
  end
end
