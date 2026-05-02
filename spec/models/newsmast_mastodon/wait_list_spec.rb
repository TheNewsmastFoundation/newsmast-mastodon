# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::WaitList, type: :model do
  it "requires :invitation_code on create" do
    validators = described_class.validators_on(:invitation_code)
    expect(validators.map(&:class)).to include(ActiveRecord::Validations::PresenceValidator)
  end

  it "defines :channel_type enum" do
    expect(NewsmastMastodon::WaitList.channel_types.keys).to contain_exactly("channel", "hub")
  end
end
