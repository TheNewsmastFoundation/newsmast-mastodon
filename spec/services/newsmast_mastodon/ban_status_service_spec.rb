# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::BanStatusService, type: :service do
  it "checks status text against configured keyword filters" do
    require_host!
  end

  it "bans matching accounts" do
    require_host!
  end

  it "returns the correct ban status symbol" do
    require_host!
  end
end
