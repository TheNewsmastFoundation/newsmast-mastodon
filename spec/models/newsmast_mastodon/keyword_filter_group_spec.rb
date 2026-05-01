# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::KeywordFilterGroup, type: :model do
  it "has_many :keyword_filters with dependent: :destroy" do
    ref = NewsmastMastodon::KeywordFilterGroup.reflect_on_association(:keyword_filters)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:has_many)
    expect(ref.options[:dependent]).to eq(:destroy)
  end
end
