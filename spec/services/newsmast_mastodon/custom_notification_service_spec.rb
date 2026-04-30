# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::CustomNotificationService, type: :service do
  it "routes by notification type (mention, reblog, follow, ...)" do
    require_host!
  end

  it "selects device tokens from NotificationToken" do
    require_host!
  end

  it "delivers via FirebaseNotificationService with correct payload" do
    require_host!
  end
end
