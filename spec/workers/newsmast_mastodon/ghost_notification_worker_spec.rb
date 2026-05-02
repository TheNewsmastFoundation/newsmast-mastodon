# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::GhostNotificationWorker, type: :worker do
  it "#perform delegates to GhostNotificationService" do
    service = instance_double("NewsmastMastodon::GhostNotificationService", call: true)
    service_class = class_double("NewsmastMastodon::GhostNotificationService", new: service)
    stub_const("NewsmastMastodon::GhostNotificationService", service_class)

    payload = { "ghost_id" => 8 }
    described_class.new.perform(payload)

    expect(NewsmastMastodon::GhostNotificationService).to have_received(:new)
    expect(service).to have_received(:call).with(payload)
  end
end
