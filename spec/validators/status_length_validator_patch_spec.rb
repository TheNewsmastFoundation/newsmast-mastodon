# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::LongPost::StatusLengthValidatorPatch, type: :validator do
  it "validates text length against ServerSetting-configured max" do
    NewsmastMastodon::ServerSetting.create!(name: "Long posts", value: true, optional_value: "650")

    validator_class = Class.new do
      prepend NewsmastMastodon::LongPost::StatusLengthValidatorPatch

      private

      def patchwork_server_settings_exist?
        true
      end
    end

    validator = validator_class.new
    expect(validator.send(:get_max_chars)).to eq(650)
  end

  it "falls back to 500 when setting is missing" do
    validator_class = Class.new do
      prepend NewsmastMastodon::LongPost::StatusLengthValidatorPatch

      private

      def patchwork_server_settings_exist?
        false
      end
    end

    validator = validator_class.new
    expect(validator.send(:get_max_chars)).to eq(500)
  end
end
