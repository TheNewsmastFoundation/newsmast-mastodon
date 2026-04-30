# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Concerns::UserConcern, type: :model do
  it "creates user-level server settings on user creation" do
    require_host!
  end

  it "applies default server settings" do
    require_host!
  end

  it "filters Threads domains by default" do
    require_host!
  end

  it "filters Bluesky domains by default" do
    require_host!
  end
end
