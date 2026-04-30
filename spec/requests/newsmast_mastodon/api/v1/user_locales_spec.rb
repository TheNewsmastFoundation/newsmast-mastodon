# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "NewsmastMastodon Api V1 UserLocales", type: :request do
  it "POST /api/v1/user_locales saves locale preference" do
    require_host!
  end
end
