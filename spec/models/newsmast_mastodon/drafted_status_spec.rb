# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::DraftedStatus, type: :model do
  it "enforces TOTAL_LIMIT (300) drafts per account" do
    expect(NewsmastMastodon::DraftedStatus::TOTAL_LIMIT).to eq(300)
  end

  it "enforces DAILY_LIMIT (25) drafts per account per day" do
    expect(NewsmastMastodon::DraftedStatus::DAILY_LIMIT).to eq(25)
  end

  it "belongs_to :account (Mastodon host)" do
    ref = described_class.reflect_on_association(:account)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
  end

  it "has_many :media_attachments" do
    ref = described_class.reflect_on_association(:media_attachments)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:has_many)
  end

  it "includes Paginable concern" do
    expect(NewsmastMastodon::DraftedStatus.ancestors).to include(Paginable)
  end
end
