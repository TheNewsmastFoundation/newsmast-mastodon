# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BrandColorHelper, type: :helper do
  it "retrieves the brand color from settings" do
    stub_const("Setting", Class.new do
      def self.find_by(*); end
    end)

    setting = instance_double("SettingRecord", value: "#1a2b3c")
    allow(Setting).to receive(:find_by).with(var: "brand_color").and_return(setting)

    expect(helper.brand_color).to eq("#1a2b3c")
  end

  it "falls back to Mastodon default brand color when setting is blank" do
    stub_const("Setting", Class.new do
      def self.find_by(*); end
    end)

    setting = instance_double("SettingRecord", value: "")
    allow(Setting).to receive(:find_by).with(var: "brand_color").and_return(setting)

    expect(helper.brand_color).to eq("#6364ff")
  end
end
