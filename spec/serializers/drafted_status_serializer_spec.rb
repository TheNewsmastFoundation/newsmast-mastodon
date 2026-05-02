# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::LongPost::DraftedStatusSerializer, type: :serializer do
  it "serializes :id" do
    drafted_status = instance_double("DraftedStatus", id: 123, params: {}, media_attachments: [])

    serializer = described_class.allocate
    serializer.define_singleton_method(:object) { drafted_status }

    expect(serializer.id).to eq("123")
  end

  it "serializes :params without :application_id" do
    params = { text: "hello", application_id: 5, visibility: "public" }
    drafted_status = instance_double("DraftedStatus", id: 1, params: params, media_attachments: [])

    serializer = described_class.allocate
    serializer.define_singleton_method(:object) { drafted_status }

    expect(serializer.params).to eq(text: "hello", visibility: "public")
  end

  it "serializes :media_attachments" do
    source = File.read(NewsmastMastodon::Engine.root.join("app/serializers/long_post/drafted_status_serializer.rb"))
    expect(source).to include("has_many :media_attachments")
  end
end
