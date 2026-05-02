# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::UserServerSetting, type: :model do
  it "belongs_to :user (Mastodon host)" do
    ref = described_class.reflect_on_association(:user)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
  end

  it "belongs_to :server_setting" do
    ref = NewsmastMastodon::UserServerSetting.reflect_on_association(:server_setting)
    expect(ref).not_to be_nil
    expect(ref.macro).to eq(:belongs_to)
    expect(ref.options[:class_name]).to eq("NewsmastMastodon::ServerSetting")
  end
end
