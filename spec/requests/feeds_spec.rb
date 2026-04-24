# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "CustomFeed timelines/@username/feed", type: :request do
  it "GET /api/v1/timelines/@username/feed returns statuses (Redis stubbed)" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "GET /api/v1/timelines/@username/feed honours max_id/since_id/min_id" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "GET /api/v1/timelines/@username/feed returns 404 for non-existent user" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end
end
