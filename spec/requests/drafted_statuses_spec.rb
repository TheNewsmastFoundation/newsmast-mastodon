# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "DraftedStatuses", type: :request do
  it "POST /api/v1/drafted_statuses creates a draft and returns the serialized draft" do
    require_host!
  end

  it "GET /api/v1/drafted_statuses lists drafts grouped by date" do
    require_host!
  end

  it "GET /api/v1/drafted_statuses/:id shows a single draft" do
    require_host!
  end

  it "PATCH /api/v1/drafted_statuses/:id updates draft params" do
    require_host!
  end

  it "DELETE /api/v1/drafted_statuses/:id destroys the draft" do
    require_host!
  end

  it "POST /api/v1/drafted_statuses/:id/publish publishes the draft to a status" do
    require_host!
  end

  it "POST /api/v1/drafted_statuses exceeding TOTAL_LIMIT (300) returns an error" do
    require_host!
  end

  it "POST /api/v1/drafted_statuses exceeding DAILY_LIMIT (25) returns an error" do
    require_host!
  end
end
