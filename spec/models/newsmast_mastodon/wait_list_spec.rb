# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::WaitList, type: :model do
  it "requires :invitation_code on create" do
    require_host!
  end

  it "defines :channel_type enum" do
    expect(NewsmastMastodon::WaitList.channel_types.keys).to contain_exactly("channel", "hub")
  end
end
