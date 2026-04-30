# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::AccountBannedWorker, type: :worker do
  it "enqueues on the expected Sidekiq queue" do
    require_host!
  end

  it "#perform delegates to BanStatusService" do
    require_host!
  end
end
