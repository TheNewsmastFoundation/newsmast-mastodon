# frozen_string_literal: true

require "rails_helper"

RSpec.describe NonChannelHelper, type: :helper do
  describe "#is_non_channel?" do
    context "in development environment" do
      it "returns true (non-channel mode enabled in development)" do
        allow(Rails.env).to receive(:development?).and_return(true)

        expect(helper.is_non_channel?).to be(true)
      end
    end

    context "in production environment" do
      before { allow(Rails.env).to receive(:development?).and_return(false) }

      it "returns false when LOCAL_DOMAIN is channel.org" do
        allow(ENV).to receive(:fetch).with("LOCAL_DOMAIN", nil).and_return("channel.org")

        expect(helper.is_non_channel?).to be(false)
      end

      it "returns false when LOCAL_DOMAIN is staging.patchwork.online" do
        allow(ENV).to receive(:fetch).with("LOCAL_DOMAIN", nil).and_return("staging.patchwork.online")

        expect(helper.is_non_channel?).to be(false)
      end

      it "returns true when LOCAL_DOMAIN is any other domain" do
        allow(ENV).to receive(:fetch).with("LOCAL_DOMAIN", nil).and_return("other.example.com")

        expect(helper.is_non_channel?).to be(true)
      end
    end
  end
end
