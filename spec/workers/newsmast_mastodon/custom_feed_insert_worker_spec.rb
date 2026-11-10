# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::CustomFeedInsertWorker, type: :worker do
  it "#perform :push calls FeedManager.push_to_custom" do
    status = instance_double("Status")
    account = instance_double("Account")

    stub_const("Status", Class.new do
      def self.find(*); end
    end)
    stub_const("Account", Class.new do
      def self.find(*); end
    end)

    allow(Status).to receive(:find).with(11).and_return(status)
    allow(Account).to receive(:find).with(22).and_return(account)

    manager = instance_double("FeedManagerInstance")
    feed_manager = Class.new do
      def self.instance; end
    end
    stub_const("FeedManager", feed_manager)

    allow(FeedManager).to receive(:instance).and_return(manager)
    allow(manager).to receive(:filter_from_custom?).and_return(false)
    allow(manager).to receive(:push_to_custom)

    worker = described_class.new
    worker.define_singleton_method(:with_primary) { |&blk| blk.call }
    worker.define_singleton_method(:with_read_replica) { |&blk| blk.call }
    worker.perform(11, 22, {})

    expect(manager).to have_received(:push_to_custom).with(account, status, update: nil)
  end

  it "#perform :unpush calls FeedManager.unpush_from_custom" do
    status = instance_double("Status")
    account = instance_double("Account")

    stub_const("Status", Class.new do
      def self.find(*); end
    end)
    stub_const("Account", Class.new do
      def self.find(*); end
    end)

    allow(Status).to receive(:find).with(33).and_return(status)
    allow(Account).to receive(:find).with(44).and_return(account)

    manager = instance_double("FeedManagerInstance")
    feed_manager = Class.new do
      def self.instance; end
    end
    stub_const("FeedManager", feed_manager)

    allow(FeedManager).to receive(:instance).and_return(manager)
    allow(manager).to receive(:filter_from_custom?).and_return(true)
    allow(manager).to receive(:unpush_from_custom)

    worker = described_class.new
    worker.define_singleton_method(:with_primary) { |&blk| blk.call }
    worker.define_singleton_method(:with_read_replica) { |&blk| blk.call }
    worker.perform(33, 44, { "update" => true })

    expect(manager).to have_received(:unpush_from_custom).with(account, status, update: true)
  end
end
