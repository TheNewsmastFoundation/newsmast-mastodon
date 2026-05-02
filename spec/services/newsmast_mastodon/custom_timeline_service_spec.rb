# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::CustomTimelineService, type: :service do
  it "#add_custom_public_status adds to the Redis sorted set" do
    redis = instance_double("Redis")
    allow(redis).to receive(:zadd)
    allow(redis).to receive(:zremrangebyrank)

    service = described_class.new
    service.define_singleton_method(:redis) { redis }
    service.add_custom_public_status(100)

    expect(redis).to have_received(:zadd).with("feed:mix_channel_local_timeline", 100, 100)
  end

  it "#remove_custom_public_status removes from the Redis sorted set" do
    redis = instance_double("Redis")
    allow(redis).to receive(:zrem)

    service = described_class.new
    service.define_singleton_method(:redis) { redis }
    service.remove_custom_public_status(100)

    expect(redis).to have_received(:zrem).with("feed:mix_channel_local_timeline", 100)
  end

  it "trims to MAX_ITEMS after insertion" do
    redis = instance_double("Redis")
    allow(redis).to receive(:zadd)
    allow(redis).to receive(:zremrangebyrank)

    service = described_class.new
    service.define_singleton_method(:redis) { redis }
    service.add_custom_public_status(321)

    expect(redis).to have_received(:zremrangebyrank).with("feed:mix_channel_local_timeline", 0, -401)
  end
end
