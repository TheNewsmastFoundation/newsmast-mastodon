# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::BanStatusWorker, type: :worker do
  it "checks a status against keyword filters" do
    require_host!
  end

  it "enqueues ReblogChannelsWorker when not banned" do
    require_host!
  end
end
