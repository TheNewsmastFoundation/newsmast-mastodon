# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::GenerateAltTextWorker, type: :worker do
  it "#perform delegates to AltTextAiApiService" do
    attachment = instance_double("MediaAttachment", id: 12, can_generate_alt?: true)

    media_attachment_class = Class.new do
      def self.find(*); end
    end
    stub_const("MediaAttachment", media_attachment_class)
    allow(MediaAttachment).to receive(:find).with(12).and_return(attachment)

    service = instance_double("NewsmastMastodon::AfterUploadImageService", call: true)
    service_class = class_double("NewsmastMastodon::AfterUploadImageService", new: service)
    stub_const("NewsmastMastodon::AfterUploadImageService", service_class)

    described_class.new.perform(12)

    expect(NewsmastMastodon::AfterUploadImageService).to have_received(:new).with(12)
    expect(service).to have_received(:call)
  end
end
