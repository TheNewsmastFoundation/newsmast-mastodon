# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "CustomFeed timelines/@username/feed", type: :request do
  let(:user)    { Fabricate(:user) }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: "read read:statuses") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }

  it "GET /api/v1/timelines/@username/feed returns statuses (Redis stubbed)" do
    require_host!
    get "/api/v1/timelines/@#{user.account.username}/feed", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to be_an(Array)
  end

  it "GET /api/v1/timelines/@username/feed honours max_id/since_id/min_id" do
    require_host!
    get "/api/v1/timelines/@#{user.account.username}/feed",
      headers: headers,
      params:  { max_id: "999999", min_id: "1", limit: 20 }

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to be_an(Array)
  end

  it "GET /api/v1/timelines/@username/feed returns 404 for non-existent user" do
    require_host!
    get "/api/v1/timelines/@nonexistentuser_#{SecureRandom.hex(6)}/feed",
      headers: headers

    expect(response).to have_http_status(:not_found)
  end
end
