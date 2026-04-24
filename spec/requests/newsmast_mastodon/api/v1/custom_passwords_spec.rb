# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "NewsmastMastodon Api V1 CustomPasswords", type: :request do
  it "POST /api/v1/custom_passwords initiates password reset and returns success" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "PATCH /api/v1/custom_passwords updates password with valid OTP" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/custom_passwords/verify_otp accepts a valid OTP" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/custom_passwords/verify_otp rejects an invalid OTP" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/custom_passwords/request_otp sends an OTP email" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/custom_passwords/change_password updates the authenticated user password" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end

  it "POST /api/v1/custom_passwords/change_email updates the authenticated user email" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 14"
  end
end
