# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::CustomFeedInsertWorker, type: :worker do
  it "#perform :push calls FeedManager.push_to_custom" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "#perform :unpush calls FeedManager.unpush_from_custom" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end
end
