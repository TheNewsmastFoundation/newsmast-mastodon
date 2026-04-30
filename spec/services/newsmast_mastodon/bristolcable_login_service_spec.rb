# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::BristolcableLoginService, type: :service do
  it "POSTs to the Bristol Cable API (HTTParty stub, success path)" do
    require_host!
  end

  it "returns an error on failure (HTTParty stub, failure path)" do
    require_host!
  end
end
