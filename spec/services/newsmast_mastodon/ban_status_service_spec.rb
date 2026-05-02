# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BanStatusService, type: :service do
  it "checks status text against configured keyword filters" do
    server_setting_class = Class.new do
      def self.find_by(*); end
    end
    stub_const("NewsmastMastodon::ServerSetting", server_setting_class)

    content_setting = instance_double("ServerSetting", value: true, name: "Content filters")
    spam_setting = instance_double("ServerSetting", value: false, name: "Spam filters")
    allow(NewsmastMastodon::ServerSetting).to receive(:find_by).with(name: "Content filters").and_return(content_setting)
    allow(NewsmastMastodon::ServerSetting).to receive(:find_by).with(name: "Spam filters").and_return(spam_setting)

    redis = instance_double("Redis")
    allow(redis).to receive(:hgetall).with("content_filters").and_return({ "1" => { keyword: "bad", filter_type: "content", is_active: true }.to_json })
    allow(redis).to receive(:hgetall).with("spam_filters").and_return({})
    allow(redis).to receive(:zadd)
    allow(redis).to receive(:zunionstore)
    allow(redis).to receive(:zcard).and_return(0)
    allow(redis).to receive(:zscore).with("excluded_status_ids", 9).and_return(nil)

    status = instance_double("Status", id: 9, tags: instance_double("Tags"), search_word_in_status: true)

    service = described_class.new
    service.define_singleton_method(:redis) { redis }
    service.define_singleton_method(:with_read_replica) { |&blk| blk.call }
    allow(service).to receive(:check_and_ban_account)

    service.check_and_ban_status(status)

    expect(redis).to have_received(:zadd).with("content_filters_banned_status_ids", 9, 9)
  end

  it "bans matching accounts" do
    account = instance_double("Account", is_banned: false, username: "spamuser", display_name: "", note: "")
    allow(account).to receive(:update)

    account_class = Class.new do
      def self.find_by(*); end
    end
    stub_const("Account", account_class)
    allow(Account).to receive(:find_by).with(id: 5).and_return(account)

    status = instance_double("Status", account_id: 5)

    service = described_class.new
    service.instance_variable_set(:@status, status)
    service.define_singleton_method(:with_primary) { |&blk| blk.call }

    service.send(:check_and_ban_account, "spamuser")

    expect(account).to have_received(:update).with(is_banned: true)
  end

  it "returns the correct ban status symbol" do
    server_setting_class = Class.new do
      def self.find_by(*); end
    end
    stub_const("NewsmastMastodon::ServerSetting", server_setting_class)
    allow(NewsmastMastodon::ServerSetting).to receive(:find_by).and_return(nil)

    redis = instance_double("Redis")
    allow(redis).to receive(:zunionstore)
    allow(redis).to receive(:zcard).and_return(0)
    allow(redis).to receive(:zscore).with("excluded_status_ids", 123).and_return("123")

    status = instance_double("Status", id: 123)

    service = described_class.new
    service.define_singleton_method(:redis) { redis }
    service.define_singleton_method(:with_read_replica) { |&blk| blk.call }

    result = service.check_and_ban_status(status)

    expect(result).to be(true)
  end
end
