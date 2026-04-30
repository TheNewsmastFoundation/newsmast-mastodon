# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "NewsmastMastodon Api V1 Channels", type: :request do
  it "GET /api/v1/channels/starter_packs_channels returns cached channel data" do
    require_host!
  end

  it "GET /api/v1/channels/starter_packs_detail returns specific channel detail" do
    require_host!
  end
end
