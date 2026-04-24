# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Concerns::FeedConcern, type: :model do
  it "#get returns Status records for given ids from Redis" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "#from_redis filters by max_id/since_id/min_id" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "#filter_and_cache_statuses caches filtered ids" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "supports exclude_directs, exclude_followed_tags, exclude_replies params" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end
end
