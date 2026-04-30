# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::LoginService, type: :service do
  it "routes channel login vs non-channel login vs Bristol Cable login" do
    require_host!
  end

  it "checks admin role on login" do
    require_host!
  end
end
