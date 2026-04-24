# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Concerns::FanOutOnWriteConcern, type: :model do
  it "fans out status writes to custom feeds via FeedManager extension" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end
end
