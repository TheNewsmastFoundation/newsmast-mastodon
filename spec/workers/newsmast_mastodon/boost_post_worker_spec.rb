# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BoostPostWorker, type: :worker do
  it "#perform delegates to BoostPostService" do
    service = instance_double("NewsmastMastodon::BoostPostService", call: true)
    service_class = class_double("NewsmastMastodon::BoostPostService", new: service)
    stub_const("NewsmastMastodon::BoostPostService", service_class)

    described_class.new.perform("https://example.org/@alice/123")

    expect(NewsmastMastodon::BoostPostService).to have_received(:new).with("https://example.org/@alice/123")
    expect(service).to have_received(:call)
  end
end
