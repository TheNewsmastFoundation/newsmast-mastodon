# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Concerns::StatusConcern, type: :model do
  it ".without_banned scope excludes is_banned: true" do
    require_host!
  end

  it ".without_local_only scope excludes local-only statuses" do
    require_host!
  end

  it "#local_only? predicate returns correct value" do
    require_host!
  end

  it "#search_word_in_status matches banned keywords" do
    require_host!
  end

  it "after_create :boost_posts fires when BOOST_POST env is set" do
    require_host!
  end

  it "after_create enqueues CustomTimelineService when applicable" do
    require_host!
  end

  it "before_create :set_locality populates locality column" do
    require_host!
  end

  it ".indexable scope excludes banned, direct, local-only statuses" do
    require_host!
  end

  it ".fetch_reblogs / .without_original_statuses / .without_direct_statuses scopes" do
    require_host!
  end

  it ".tagged_without(tag_ids) scope excludes statuses tagged with given ids" do
    require_host!
  end
end
