# frozen_string_literal: true

require "rails_helper"

RSpec.describe CustomPasswordsMailer, type: :mailer do
  let(:user) { instance_double("User", email: "user@example.org") }

  it "sends OTP verification email with correct subject" do
    mailer = described_class.new
    allow(mailer).to receive(:params).and_return({ user: user })
    expect(mailer).to receive(:mail).with(hash_including(subject: "OTP verification code")).and_return(Mail::Message.new)

    mailer.reset_password_confirmation
  end

  it "addresses the recipient" do
    mailer = described_class.new
    allow(mailer).to receive(:params).and_return({ user: user })
    expect(mailer).to receive(:mail).with(hash_including(to: "user@example.org")).and_return(Mail::Message.new)

    mailer.reset_password_confirmation
  end

  it "includes the OTP code in the body" do
    mailer = described_class.new
    allow(mailer).to receive(:params).and_return({ user: user })
    message = Mail::Message.new(body: "Your OTP is 123456")
    allow(mailer).to receive(:mail).and_return(message)

    result = mailer.reset_password_confirmation

    expect(result.body.to_s).to include("123456")
  end
end
