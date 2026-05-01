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
    require_host!
  end

  it "has_many :media_attachments" do
    require_host!
  end

  it "includes Paginable concern" do
    expect(NewsmastMastodon::DraftedStatus.ancestors).to include(Paginable)
  end
end
