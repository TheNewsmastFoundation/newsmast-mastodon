# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::Overrides::ReblogServiceExtension, type: :service do
  it "respects :local_only when reblogging" do
    reblog = instance_double("Status", id: 99)
    reblogged_status = instance_double("Status", reblog?: false, hidden?: false, local_only?: true)

    statuses = instance_double("StatusesAssociation")
    account = instance_double("Account", statuses: statuses, user: nil)

    allow(statuses).to receive(:find_by).with(reblog: reblogged_status).and_return(nil)
    allow(statuses).to receive(:create!).and_return(reblog)

    stub_const("Trends", Module.new)
    Trends.define_singleton_method(:register!) { |_status| true }

    stub_const("DistributionWorker", class_double("DistributionWorker", perform_async: true))

    stub_const("ActivityPub", Module.new)
    activitypub_distribution = class_double("ActivityPub::DistributionWorker", perform_async: true)
    ActivityPub.const_set(:DistributionWorker, activitypub_distribution)

    service_class = Class.new do
      include NewsmastMastodon::Overrides::ReblogServiceExtension

      private

      def authorize_with(*); end

      def create_notification(*); end

      def increment_statistics; end
    end

    service_class.new.call(account, reblogged_status)

    expect(DistributionWorker).to have_received(:perform_async).with(99)
    expect(ActivityPub::DistributionWorker).not_to have_received(:perform_async)
  end
end
