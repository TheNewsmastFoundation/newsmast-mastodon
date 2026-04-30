# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::CustomFeed, type: :model do
  it "#get(limit, max_id, since_id, min_id) fetches status ids from Redis" do
    require_host!
  end

  it "filters out replies when exclude_replies is true" do
    require_host!
  end

  it "filters out reblogs when exclude_reblogs is true" do
    require_host!
  end

  it "filters out posts without media when media_only is true" do
    require_host!
  end
end
