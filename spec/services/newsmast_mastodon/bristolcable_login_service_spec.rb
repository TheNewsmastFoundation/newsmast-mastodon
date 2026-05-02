# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BristolcableLoginService, type: :service do
  it "POSTs to the Bristol Cable API (HTTParty stub, success path)" do
    user_class = Class.new do
      def self.find_by(*); end
    end
    stub_const("User", user_class)
    allow(User).to receive(:find_by).and_return(nil)

    login_response = instance_double("HTTPartyResponse", code: 204, headers: { "Set-Cookie" => "session=abc" }, parsed_response: {})
    contact_response = instance_double("HTTPartyResponse", code: 200, parsed_response: { "firstname" => "Sam", "lastname" => "Jones" })

    allow(HTTParty).to receive(:post).and_return(login_response)
    allow(HTTParty).to receive(:get).and_return(contact_response)

    allow(I18n).to receive(:t).and_call_original
    allow(I18n).to receive(:t).with("bristolcable_login_service.errors.registration_required", anything).and_return("registration_required")

    result = described_class.new(username: "a@b.com", password: "secret").login

    expect(HTTParty).to have_received(:post).with(
      "https://membership.thebristolcable.org/api/1.0/auth/login",
      headers: { "Content-Type" => "application/json" },
      body: kind_of(String)
    )
    expect(result).to eq("registration_required")
  end

  it "returns an error on failure (HTTParty stub, failure path)" do
    user_class = Class.new do
      def self.find_by(*); end
    end
    stub_const("User", user_class)
    allow(User).to receive(:find_by).and_return(nil)

    login_response = instance_double("HTTPartyResponse", code: 401, headers: {}, parsed_response: {})
    allow(HTTParty).to receive(:post).and_return(login_response)

    allow(I18n).to receive(:t).and_call_original
    allow(I18n).to receive(:t).with("bristolcable_login_service.errors.invalid_credentials").and_return("invalid_credentials")

    result = described_class.new(username: "a@b.com", password: "wrong").login

    expect(result).to eq("invalid_credentials")
  end
end
