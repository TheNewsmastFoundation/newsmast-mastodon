# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::WaitList, type: :model do
  it "generates an invitation code on create" do
    require_host!
  end

  it "defines :channel_type enum" do
    require_host!
  end
end
