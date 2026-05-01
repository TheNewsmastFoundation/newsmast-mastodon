# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::CommunityPostType, type: :model do
  it "belongs_to :community" do
    ref = NewsmastMastodon::CommunityPostType.reflect_on_association(:community)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
    expect(ref.options[:foreign_key]).to eq("patchwork_community_id")
  end
end
