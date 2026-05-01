# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::CommunityHashtag, type: :model do
  it "belongs_to :community" do
    ref = NewsmastMastodon::CommunityHashtag.reflect_on_association(:community)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
  end

  it "references community via patchwork_community_id foreign key" do
    ref = NewsmastMastodon::CommunityHashtag.reflect_on_association(:community)
    expect(ref.options[:foreign_key]).to eq("patchwork_community_id")
  end
end
