# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "CustomBoostBot statuses", type: :request do
  it "POST /api/v1/custom_statuses/add_custom_boost_bot_status adds status by URL" do
    require_host!
  end

  it "POST /api/v1/custom_statuses/remove_custom_boost_bot_status removes status by id" do
    require_host!
  end
end
