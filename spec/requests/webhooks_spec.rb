# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "GhostWebhooks", type: :request do
  it "POST /ghost_webhooks with valid HMAC triggers GhostNotificationWorker" do
    require_host!
  end

  it "POST /ghost_webhooks with invalid HMAC returns 401" do
    require_host!
  end

  it "POST /ghost_webhooks with malformed payload returns 400" do
    require_host!
  end
end

RSpec.describe "WordPressWebhooks", type: :request do
  it "POST /wordpress_webhooks with valid auth_token triggers ArticleNotificationWorker" do
    require_host!
  end

  it "POST /wordpress_webhooks with invalid auth_token returns 401" do
    require_host!
  end

  it "POST /wordpress_webhooks with missing payload returns 422" do
    require_host!
  end
end
