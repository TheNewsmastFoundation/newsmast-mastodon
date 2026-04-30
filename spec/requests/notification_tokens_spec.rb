# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "NotificationTokens", type: :request do
  it "POST /api/v1/notification_tokens creates a token and returns 200" do
    require_host!
  end

  it "POST /api/v1/notification_tokens with a duplicate token returns an appropriate error" do
    require_host!
  end

  it "DELETE /api/v1/notification_tokens/revoke_notification_token revokes the token" do
    require_host!
  end

  it "POST /api/v1/notification_tokens/update_mute updates the mute status" do
    require_host!
  end

  it "GET /api/v1/notification_tokens/get_mute_status returns the current mute state" do
    require_host!
  end
end
