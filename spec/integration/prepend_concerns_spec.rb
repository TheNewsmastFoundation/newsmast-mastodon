# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Concern prepends", type: :integration do
  it "Status ancestors include NewsmastMastodon::Concerns::StatusConcern" do
    require_host!
  end

  it "Account ancestors include NewsmastMastodon::Concerns::AccountConcern" do
    require_host!
  end

  it "Feed ancestors include NewsmastMastodon::Concerns::FeedConcern" do
    require_host!
  end

  it "User ancestors include NewsmastMastodon::Concerns::UserConcern" do
    require_host!
  end

  it "all controller prepends resolve to NewsmastMastodon::Overrides::*" do
    require_host!
  end
end
