# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::Overrides::UpdateStatusServiceExtension, type: :service do
  let(:service_class) do
    Class.new do
      include NewsmastMastodon::Overrides::UpdateStatusServiceExtension

      def initialize(status)
        @status = status
      end

      def call_broadcast_updates!
        send(:broadcast_updates!)
      end
    end
  end

  it "preserves :local_only on status updates" do
    status = instance_double("Status", id: 7, local_only?: true)

    stub_const("DistributionWorker", class_double("DistributionWorker", perform_async: true))

    stub_const("ActivityPub", Module.new)
    update_worker = class_double("ActivityPub::StatusUpdateDistributionWorker", perform_async: true)
    ActivityPub.const_set(:StatusUpdateDistributionWorker, update_worker)

    service = service_class.new(status)
    service.call_broadcast_updates!

    expect(DistributionWorker).to have_received(:perform_async).with(7, { "update" => true })
    expect(ActivityPub::StatusUpdateDistributionWorker).not_to have_received(:perform_async)
  end
end
