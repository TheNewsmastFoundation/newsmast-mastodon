# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Engine migrations", type: :integration do
  it "all 15 migrations run cleanly on a fresh database" do
    require_host!
  end

  it "ActiveRecord::Migration.check_all_pending! passes after maintain_test_schema!" do
    require_host!
  end
end
