# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::ServerSetting, type: :model do
  it "validates presence of :name" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "allows nil :optional_value" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "belongs_to :parent and has_many :children" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "has_many :user_server_settings" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it ".get_long_post(name) returns the expected setting value" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end
end
