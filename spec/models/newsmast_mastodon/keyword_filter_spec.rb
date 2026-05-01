# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::KeywordFilter, type: :model do
  it "defines :filter_type enum (content/hashtag/both)" do
    expect(NewsmastMastodon::KeywordFilter.filter_types.keys).to contain_exactly("content", "hashtag", "both")
  end

  it "uses the keyword_filters table" do
    expect(NewsmastMastodon::KeywordFilter.table_name).to eq("keyword_filters")
  end
end
