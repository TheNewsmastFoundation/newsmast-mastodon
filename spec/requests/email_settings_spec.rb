# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "EmailSettings", type: :request do
  let(:user)    { Fabricate(:user) }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: "read write") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }

  it "POST /api/v1/patchwork/email_settings/notification updates email notification preferences" do
    require_host!
    post "/api/v1/patchwork/email_settings/notification",
      headers: headers,
      params: { allowed: true }

    expect(response).to have_http_status(:ok)
  end

  it "GET /api/v1/patchwork/email_settings returns the current email notification settings" do
    require_host!
    get "/api/v1/patchwork/email_settings", headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to have_key("data")
  end

  it "POST /api/v1/patchwork/email_settings/notification unauthenticated returns 401" do
    require_host!
    post "/api/v1/patchwork/email_settings/notification", params: { allowed: true }

    expect(response).to have_http_status(:unauthorized)
  end
end
