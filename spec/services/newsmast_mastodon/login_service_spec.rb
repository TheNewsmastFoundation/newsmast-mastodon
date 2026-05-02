# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::LoginService, type: :service do
  it "routes channel login vs non-channel login vs Bristol Cable login" do
    params = { grant_type: "client_credentials", is_web_login: "false" }
    service = described_class.new(params)

    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with("MAIN_CHANNEL", nil).and_return("true")
    allow(ENV).to receive(:fetch).with("LOCAL_DOMAIN", nil).and_return("thebristolcable.social")

    bristol = instance_double("NewsmastMastodon::BristolcableLoginService", login: "ok")
    bristol_class = class_double("NewsmastMastodon::BristolcableLoginService", new: bristol)
    stub_const("NewsmastMastodon::BristolcableLoginService", bristol_class)

    expect(service.channel_login).to be_nil
    expect(service.non_channel_login).to be_nil
    expect(service.bristol_cable_login).to eq("ok")
  end

  it "checks admin role on login" do
    params = {
      grant_type: "password",
      is_web_login: "true",
      username: "user@example.org"
    }

    service = described_class.new(params)

    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with("MAIN_CHANNEL", nil).and_return("true")

    role = instance_double("Role", name: "Viewer")
    user = instance_double("User", confirmed_at: Time.now, role: role)

    user_class = Class.new do
      def self.find_by(*); end
    end
    stub_const("User", user_class)
    allow(User).to receive(:find_by).with(email: "user@example.org").and_return(user)

    allow(I18n).to receive(:t).and_call_original
    allow(I18n).to receive(:t).with("login_service.errors.invalid_role_access", role: "Viewer").and_return("invalid_role")

    expect(service.channel_login).to eq("invalid_role")
  end
end
