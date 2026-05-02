# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::BanTagWorker, type: :worker do
  it "bans tags matching configured keyword filters" do
    keyword_filter_class = Class.new do
      def self.where(*); end
    end
    community_filter_class = Class.new do
      def self.where(*); end
    end

    stub_const("NewsmastMastodon::KeywordFilter", keyword_filter_class)
    stub_const("NewsmastMastodon::CommunityFilterKeyword", community_filter_class)

    allow(NewsmastMastodon::KeywordFilter).to receive(:where).and_return([])
    allow(NewsmastMastodon::CommunityFilterKeyword).to receive(:where).and_return([])
    allow(Rails.logger).to receive(:info)

    expect { described_class.new.perform }.not_to raise_error
    expect(Rails.logger).to have_received(:info).with("No hashtag or both type keyword filters found. Exiting.")
  end
end
