# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "NewsmastMastodon Api V1 Patchwork EmailSettings", type: :request do
  let(:user)    { Fabricate(:user) }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: "read write") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }

  it "PATCH /api/v1/patchwork/email_settings updates preferences" do
    require_host!
    post "/api/v1/patchwork/email_settings/notification",
      headers: headers,
      params: { allowed: true }

    expect(response).to have_http_status(:ok)
  end
end
