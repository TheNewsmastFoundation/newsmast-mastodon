# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Consolidated engine routes", type: :routing do
  it "routes accounts: custom_passwords, notification_tokens, user_locales, channels, patchwork/*" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "routes conversations: /api/v1/patchwork/conversations/*" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "routes custom_feeds: timelines/@user/feed, for_you_custom_timeline, custom_statuses/*" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "routes local_only_posts: getLocalOnlySetting" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "routes posts: drafted_statuses/*, utilities/link_preview, relays, ghost_webhooks" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end
end
