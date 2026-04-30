# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "ForYouCustomTimeline", type: :request do
  it "GET /api/v1/timelines/for_you_custom_timeline returns personalized timeline for authenticated user" do
    require_host!
  end

  it "GET /api/v1/timelines/for_you_custom_timeline returns 401 when unauthenticated" do
    require_host!
  end
end
