# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::ReblogChannelsWorker, type: :worker do
  it "performs reblog to community/channel" do
    stub_const("Account", Class.new do
      def self.find_by(*); end
    end)

    allow(Account).to receive(:find_by).with(id: 7).and_return(nil)

    expect(described_class.new.perform(12, 7)).to be(false)
  end
end
