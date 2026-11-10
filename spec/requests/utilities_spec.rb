# frozen_string_literal: true

#
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "Utilities", type: :request do
  it "GET /api/v1/utilities/link_preview returns link preview data (FetchLinkMetadataService stubbed)" do
    require_host!
    fake_data = {
      title: "Example",
      description: "A test page",
      images: [ { src: "https://example.com/image.png", width: 0, height: 0 } ],
      url: "https://example.com"
    }
    service = instance_double(NewsmastMastodon::FetchLinkMetadataService, call: fake_data)
    allow(NewsmastMastodon::FetchLinkMetadataService).to receive(:new).and_return(service)

    get "/api/v1/utilities/link_preview",
      params: { url: "https://example.com" }

    expect(response).to have_http_status(:ok)
  end
end
