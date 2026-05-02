# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::LongPost::InstanceSerializerExtension, type: :serializer do
  let(:serializer_class) do
    base_serializer = Class.new do
      def configuration
        { statuses: { baseline: true } }
      end
    end

    Class.new(base_serializer) do
      include NewsmastMastodon::LongPost::InstanceSerializerExtension
    end
  end

  let(:serializer) { serializer_class.new }

  before do
    stub_const("StatusLengthValidator", Class.new)
    StatusLengthValidator.const_set(:URL_PLACEHOLDER_CHARS, 23)
  end

  it "reads max_characters from NewsmastMastodon::ServerSetting" do
    NewsmastMastodon::ServerSetting.create!(name: "Long posts", value: true, optional_value: "777")

    expect(serializer.configuration.dig(:statuses, :max_characters)).to eq(777)
  end

  it "falls back to 500 when setting is missing" do
    expect(serializer.configuration.dig(:statuses, :max_characters)).to eq(500)
  end
end
