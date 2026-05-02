# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::ArticleNotificationWorker do
  it "enqueues and calls ArticleNotificationService with the article data" do
    service = instance_double("NewsmastMastodon::ArticleNotificationService", call: true)
    service_class = class_double("NewsmastMastodon::ArticleNotificationService", new: service)
    stub_const("NewsmastMastodon::ArticleNotificationService", service_class)

    payload = { "id" => 1, "title" => "Hello" }
    described_class.new.perform(payload)

    expect(NewsmastMastodon::ArticleNotificationService).to have_received(:new)
    expect(service).to have_received(:call).with(payload)
  end

  it "logs an error and returns an error hash when the service raises" do
    service = instance_double("NewsmastMastodon::ArticleNotificationService")
    service_class = class_double("NewsmastMastodon::ArticleNotificationService", new: service)
    stub_const("NewsmastMastodon::ArticleNotificationService", service_class)
    allow(service).to receive(:call).and_raise(StandardError, "boom")

    allow(Rails.logger).to receive(:error)

    result = described_class.new.perform({ "id" => 9 })

    expect(result).to eq(status: :error, error: "boom")
    expect(Rails.logger).to have_received(:error)
  end
end
