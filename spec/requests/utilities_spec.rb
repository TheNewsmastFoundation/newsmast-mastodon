# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Utilities", type: :request do
  it "GET /api/v1/utilities/link_preview returns link preview data (LinkThumbnailer stubbed)" do
    require_host!
    fake_data = { title: "Example", description: "A test page" }
    allow(LinkThumbnailer).to receive(:generate).and_return(fake_data)

    get "/api/v1/utilities/link_preview",
      params: { url: "https://example.com" }

    expect(response).to have_http_status(:ok)
  end
end
