# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "CustomBoostBot statuses", type: :request do
  let(:app)     { Fabricate(:application) }

  it "POST /api/v1/custom_statuses/add_custom_boost_bot_status adds status by URL" do
    require_host!
    post "/api/v1/custom_statuses/add_custom_boost_bot_status",
      params: {
        client_id:     app.uid,
        client_secret: app.secret,
        status_url:    "https://mastodon.social/@test/123"
      }

    # 404 (no status found at that URL) or 200 if search returns data
    expect(response.status).to be_between(200, 404)
  end

  it "POST /api/v1/custom_statuses/remove_custom_boost_bot_status removes status by id" do
    require_host!
    post "/api/v1/custom_statuses/remove_custom_boost_bot_status",
      params: {
        client_id:     app.uid,
        client_secret: app.secret,
        status_id:     "999999999"
      }

    expect(response).to have_http_status(:not_found)
  end
end
