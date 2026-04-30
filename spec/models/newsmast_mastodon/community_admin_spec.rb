# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::CommunityAdmin, type: :model do
  it "belongs_to :community" do
    require_host!
  end

  it "belongs_to :account (Mastodon host)" do
    require_host!
  end

  it "defines :account_status enum (active/suspended/deleted)" do
    require_host!
  end

  it "validates uniqueness of (community_id, account_id)" do
    require_host!
  end
end
