# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::NotificationToken, type: :model do
  it "validates presence of :platform_type" do
    require_host!
  end

  it "validates uniqueness of :notification_token" do
    require_host!
  end

  it "belongs_to :account (Mastodon host)" do
    require_host!
  end
end
