# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::CommunityAdmin, type: :model do
  it "belongs_to :community" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "belongs_to :account (Mastodon host)" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "defines :account_status enum (active/suspended/deleted)" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "validates uniqueness of (community_id, account_id)" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end
end
