# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::FeedService, type: :service do
  it "returns excluded status ids from Redis (stubbed)" do
    content_filters_setting = instance_double("ServerSetting", value: true)
    spam_filters_setting = instance_double("ServerSetting", value: false)

    where_content = instance_double("WhereContent", last: content_filters_setting)
    where_spam = instance_double("WhereSpam", last: spam_filters_setting)

    allow(NewsmastMastodon::ServerSetting).to receive(:where).with(name: "Content filters").and_return(where_content)
    allow(NewsmastMastodon::ServerSetting).to receive(:where).with(name: "Spam filters").and_return(where_spam)

    redis = instance_double("Redis", zrange: %w[1 2 3])
    service = described_class.new
    service.define_singleton_method(:redis) { redis }

    result = service.excluded_status_ids

    expect(redis).to have_received(:zrange).with("content_filters_banned_status_ids", 0, -1)
    expect(result).to eq(%w[1 2 3])
  end
end
