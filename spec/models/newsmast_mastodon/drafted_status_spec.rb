# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::DraftedStatus, type: :model do
  it "enforces TOTAL_LIMIT (300) drafts per account" do
    require_host!
  end

  it "enforces DAILY_LIMIT (25) drafts per account per day" do
    require_host!
  end

  it "belongs_to :account (Mastodon host)" do
    require_host!
  end

  it "has_many :media_attachments" do
    require_host!
  end

  it "includes Paginable concern" do
    require_host!
  end
end
