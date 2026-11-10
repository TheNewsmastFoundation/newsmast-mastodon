# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::ReblogChannelsService, type: :service do
  it "reblogs to custom/group channels based on keyword filter matches" do
    status = instance_double("Status", sensitive?: true, unlisted_visibility?: false)

    worker_class = class_double("NewsmastMastodon::ReblogChannelsWorker", perform_async: true)
    stub_const("NewsmastMastodon::ReblogChannelsWorker", worker_class)

    distribution_worker = class_double("DistributionWorker", perform_async: true)
    stub_const("DistributionWorker", distribution_worker)

    described_class.new.call(status)

    expect(NewsmastMastodon::ReblogChannelsWorker).not_to have_received(:perform_async)
    expect(DistributionWorker).not_to have_received(:perform_async)
  end
end
