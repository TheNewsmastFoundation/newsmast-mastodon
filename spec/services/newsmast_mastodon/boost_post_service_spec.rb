# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BoostPostService, type: :service do
  it "sets HMAC auth headers" do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("BOOST_POST_INSTANCE_URL").and_return("https://instance.example")
    allow(ENV).to receive(:[]).with("BOOST_POST_API_KEY").and_return("api-key")
    allow(ENV).to receive(:[]).with("BOOST_POST_API_SECRET").and_return("api-secret")
    allow(ENV).to receive(:[]).with("BOOST_POST_USERNAME").and_return("bot")
    allow(ENV).to receive(:[]).with("BOOST_POST_USER_DOMAIN").and_return("example.org")

    uri = URI("https://instance.example/api/v1/statuses/boost_post")
    http = instance_double("Net::HTTP")
    request = instance_double("Net::HTTP::Post")
    response = instance_double("Net::HTTPResponse", body: { status: "ok", body: "done" }.to_json)

    allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_return(http)
    allow(Net::HTTP::Post).to receive(:new).with(uri, "Content-Type" => "application/json").and_return(request)
    allow(request).to receive(:[]=)
    allow(request).to receive(:body=)
    allow(http).to receive(:use_ssl=)
    allow(http).to receive(:request).with(request).and_return(response)

    described_class.new("https://example.org/@alice/10").call

    expect(request).to have_received(:[]=).with("x-api-key", "api-key")
    expect(request).to have_received(:[]=).with("x-api-secret", "api-secret")
  end

  it "POSTs to the external endpoint (HTTParty stub)" do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("BOOST_POST_INSTANCE_URL").and_return("https://instance.example")
    allow(ENV).to receive(:[]).with("BOOST_POST_API_KEY").and_return("api-key")
    allow(ENV).to receive(:[]).with("BOOST_POST_API_SECRET").and_return("api-secret")
    allow(ENV).to receive(:[]).with("BOOST_POST_USERNAME").and_return("bot")
    allow(ENV).to receive(:[]).with("BOOST_POST_USER_DOMAIN").and_return("example.org")

    uri = URI("https://instance.example/api/v1/statuses/boost_post")
    http = instance_double("Net::HTTP")
    request = instance_double("Net::HTTP::Post")
    response = instance_double("Net::HTTPResponse", body: { status: "ok", body: "boosted" }.to_json)

    allow(Net::HTTP).to receive(:new).with(uri.host, uri.port).and_return(http)
    allow(Net::HTTP::Post).to receive(:new).with(uri, "Content-Type" => "application/json").and_return(request)
    allow(request).to receive(:[]=)
    allow(request).to receive(:body=)
    allow(http).to receive(:use_ssl=)
    allow(http).to receive(:request).with(request).and_return(response)

    result = described_class.new("https://example.org/@alice/10").call

    expect(http).to have_received(:request).with(request)
    expect(result).to eq(status: "ok", body: "boosted")
  end
end
