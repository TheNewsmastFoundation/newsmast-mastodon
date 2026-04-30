# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Community, type: :model do
  it "validates image size limits on logo and header attachments" do
    require_host!
  end

  it "validates attachment content types (image/png, image/jpeg, image/webp)" do
    require_host!
  end

  it "has_many :community_admins" do
    require_host!
  end

  it "has_many :community_hashtags" do
    require_host!
  end

  it "has_many :community_post_types" do
    require_host!
  end

  it "defines :visibility enum with expected values" do
    require_host!
  end

  it "defines :post_visibility enum with expected values" do
    require_host!
  end

  it "processes image attachments through ActiveStorage variants" do
    require_host!
  end
end
