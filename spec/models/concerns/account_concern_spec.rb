# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Concerns::AccountConcern, type: :model do
  it ".without_banned scope" do
    require_host!
  end

  it ".channel_admins scope" do
    require_host!
  end

  it "federation exclusion helpers" do
    require_host!
  end

  it "has_many :followed_tags" do
    require_host!
  end

  it "has_many :patchwork_drafted_statuses" do
    require_host!
  end
end
