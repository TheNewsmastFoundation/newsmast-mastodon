# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::PatchworkSetting, type: :model do
  it "validates uniqueness of :account_id scoped to :app_name" do
    require_host!
  end

  it "defines :app_name enum" do
    require_host!
  end

  it "validates presence of :settings" do
    require_host!
  end

  it "belongs_to :account (Mastodon host)" do
    require_host!
  end
end
