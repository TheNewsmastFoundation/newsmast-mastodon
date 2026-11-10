# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::ReblogPostWorker, type: :worker do
  it "#perform delegates to ReblogPostService" do
    service = instance_double("NewsmastMastodon::ReblogPostService", call: true)
    service_class = class_double("NewsmastMastodon::ReblogPostService", new: service)
    stub_const("NewsmastMastodon::ReblogPostService", service_class)

    described_class.new.perform("https://example.org/@alice/123")

    expect(NewsmastMastodon::ReblogPostService).to have_received(:new).with("https://example.org/@alice/123")
    expect(service).to have_received(:call)
  end
end
