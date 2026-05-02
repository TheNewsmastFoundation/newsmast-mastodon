# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Patchwork Relays", type: :request do
  let(:owner)   { Fabricate(:owner_user) }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: owner.id, scopes: "read write admin:read admin:write") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }

  it "POST /patchwork/relays allows admin to create a relay" do
    require_host!
    inbox_url = "https://relay#{SecureRandom.hex(4)}.example.com/inbox"
    allow_any_instance_of(Relay).to receive(:enable!)

    post "/api/v1/patchwork/relays",
      headers: headers,
      params:  { inbox_url: inbox_url }

    expect(response).to have_http_status(:ok)
  end

  it "DELETE /patchwork/relays/:id allows admin to destroy a relay" do
    require_host!
    relay = Fabricate(:relay)

    delete "/api/v1/patchwork/relays/#{relay.id}", headers: headers

    expect(response).to have_http_status(:ok)
  end

  it "POST /patchwork/relays returns 403 for non-admin" do
    require_host!
    regular_user  = Fabricate(:user)
    regular_token = Fabricate(:accessible_access_token, resource_owner_id: regular_user.id, scopes: "read write")

    post "/api/v1/patchwork/relays",
      headers: { "Authorization" => "Bearer #{regular_token.token}" },
      params:  { inbox_url: "https://relay.example.com/inbox" }

    expect(response).to have_http_status(:forbidden)
  end
end
