# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Channels", type: :request do
  let(:user)    { Fabricate(:user) }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: "read write") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }

  it "GET /api/v1/channels/starter_packs_channels returns cached channel data" do
    require_host!
    get "/api/v1/channels/starter_packs_channels", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to have_key("data")
  end

  it "GET /api/v1/channels/:id/starter_packs_detail returns the detail for a specific channel" do
    require_host!
    get "/api/v1/channels/1/starter_packs_detail", headers: headers

    expect(response.status).to be_in([200, 304, 404])
  end
end
