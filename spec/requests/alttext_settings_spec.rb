# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "AlttextSettings", type: :request do
  it "POST /api/v1/patchwork/alttext_settings/alttext toggles the alttext_enabled flag and returns success" do
    require_host!
  end

  it "GET /api/v1/patchwork/alttext_settings returns the current alttext setting for the account" do
    require_host!
  end

  it "POST /api/v1/patchwork/alttext_settings/alttext unauthenticated returns 401" do
    require_host!
  end
end
