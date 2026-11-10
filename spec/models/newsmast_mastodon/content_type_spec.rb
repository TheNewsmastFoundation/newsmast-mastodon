# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::ContentType, type: :model do
  it "defines :channel_type enum (broadcast/group/custom)" do
    expect(NewsmastMastodon::ContentType.channel_types.keys).to contain_exactly("broadcast_channel", "group_channel", "custom_channel")
  end

  it "defines :custom_condition enum" do
    expect(NewsmastMastodon::ContentType.custom_conditions.keys).to contain_exactly("or_condition", "and_condition")
  end
end
