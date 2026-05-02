# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::CommunityAdmin, type: :model do
  it "belongs_to :community" do
    ref = NewsmastMastodon::CommunityAdmin.reflect_on_association(:community)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
    expect(ref.options[:foreign_key]).to eq("patchwork_community_id")
  end

  it "belongs_to :account (Mastodon host)" do
    ref = described_class.reflect_on_association(:account)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
  end

  it "defines :account_status enum (active/suspended/deleted)" do
    expect(NewsmastMastodon::CommunityAdmin.account_statuses.keys).to contain_exactly("active", "suspended", "deleted")
  end

  it "uses the patchwork_communities_admins table" do
    expect(NewsmastMastodon::CommunityAdmin.table_name).to eq("patchwork_communities_admins")
  end
end
