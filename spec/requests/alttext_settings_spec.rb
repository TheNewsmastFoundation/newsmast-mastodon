# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "AlttextSettings", type: :request do
  let(:user)    { Fabricate(:user) }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: "read write") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }

  it "POST /api/v1/patchwork/alttext_settings/alttext toggles the alttext_enabled flag and returns success" do
    require_host!
    post "/api/v1/patchwork/alttext_settings/alttext",
      headers: headers,
      params: { enabled: true }

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body["data"]).to be_in([true, false])
  end

  it "GET /api/v1/patchwork/alttext_settings returns the current alttext setting for the account" do
    require_host!
    get "/api/v1/patchwork/alttext_settings", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body["data"]).to be_in([true, false, nil])
  end

  it "POST /api/v1/patchwork/alttext_settings/alttext unauthenticated returns 401" do
    require_host!
    post "/api/v1/patchwork/alttext_settings/alttext", params: { enabled: true }

    expect(response).to have_http_status(:unauthorized)
  end
end
