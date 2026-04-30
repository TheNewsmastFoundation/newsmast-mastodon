# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::LongPost::StatusLengthValidatorPatch, type: :validator do
  it "validates text length against ServerSetting-configured max" do
    require_host!
  end

  it "falls back to 500 when setting is missing" do
    require_host!
  end
end
