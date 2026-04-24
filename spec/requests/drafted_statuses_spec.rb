# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "DraftedStatuses", type: :request do
  it "POST /api/v1/drafted_statuses creates a draft and returns the serialized draft" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "GET /api/v1/drafted_statuses lists drafts grouped by date" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "GET /api/v1/drafted_statuses/:id shows a single draft" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "PATCH /api/v1/drafted_statuses/:id updates draft params" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "DELETE /api/v1/drafted_statuses/:id destroys the draft" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/drafted_statuses/:id/publish publishes the draft to a status" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/drafted_statuses exceeding TOTAL_LIMIT (300) returns an error" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/drafted_statuses exceeding DAILY_LIMIT (25) returns an error" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end
end
