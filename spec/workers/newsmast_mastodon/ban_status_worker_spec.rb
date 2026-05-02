# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BanStatusWorker, type: :worker do
  it "checks a status against keyword filters" do
    status = instance_double("Status", local?: false)
    relation = instance_double("StatusRelation")

    stub_const("Status", Class.new do
      def self.includes(*); end
    end)

    allow(Status).to receive(:includes).with(:account, :tags).and_return(relation)
    allow(relation).to receive(:find_by).with(id: 55).and_return(status)

    ban_service = instance_double("NewsmastMastodon::BanStatusService", check_and_ban_status: true)
    ban_service_class = class_double("NewsmastMastodon::BanStatusService", new: ban_service)
    stub_const("NewsmastMastodon::BanStatusService", ban_service_class)

    allow(status).to receive(:update!).and_return(true)

    described_class.new.perform(55)

    expect(ban_service).to have_received(:check_and_ban_status).with(status)
    expect(status).to have_received(:update!).with(hash_including(is_banned: true))
  end

  it "enqueues ReblogChannelsWorker when not banned" do
    status = instance_double("Status", local?: false)
    relation = instance_double("StatusRelation")

    stub_const("Status", Class.new do
      def self.includes(*); end
    end)

    allow(Status).to receive(:includes).with(:account, :tags).and_return(relation)
    allow(relation).to receive(:find_by).with(id: 88).and_return(status)

    ban_service = instance_double("NewsmastMastodon::BanStatusService", check_and_ban_status: false)
    ban_service_class = class_double("NewsmastMastodon::BanStatusService", new: ban_service)
    stub_const("NewsmastMastodon::BanStatusService", ban_service_class)

    reblog_service = instance_double("NewsmastMastodon::ReblogChannelsService", call: true)
    reblog_service_class = class_double("NewsmastMastodon::ReblogChannelsService", new: reblog_service)
    stub_const("NewsmastMastodon::ReblogChannelsService", reblog_service_class)

    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with("MAIN_CHANNEL", nil).and_return("true")
    allow(ENV).to receive(:fetch).with("BOOST_BOT_ENABLED", nil).and_return(nil)

    described_class.new.perform(88)

    expect(reblog_service).to have_received(:call).with(status)
  end
end
