# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "CustomPasswords", type: :request do
  it "POST /api/v1/custom_passwords initiates a password reset and returns success" do
    require_host!
  end

  it "PATCH /api/v1/custom_passwords updates the password with a valid OTP" do
    require_host!
  end

  it "POST /api/v1/custom_passwords/verify_otp returns success for a valid OTP" do
    require_host!
  end

  it "POST /api/v1/custom_passwords/verify_otp returns an error for an invalid OTP" do
    require_host!
  end

  it "GET /api/v1/custom_passwords/request_otp sends an OTP email" do
    require_host!
  end

  it "POST /api/v1/custom_passwords/change_password allows an authenticated user to change their password" do
    require_host!
  end

  it "POST /api/v1/custom_passwords/change_email allows an authenticated user to change their email" do
    require_host!
  end

  it "POST /api/v1/custom_passwords/bristol_cable_sign_in authenticates via Bristol Cable" do
    require_host!
  end
end
