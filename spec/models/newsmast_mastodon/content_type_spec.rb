# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::ContentType, type: :model do
  it "defines :channel_type enum (broadcast/group/custom)" do
    require_host!
  end

  it "defines :custom_condition enum" do
    require_host!
  end
end
