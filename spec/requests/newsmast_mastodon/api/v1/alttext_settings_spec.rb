# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 14.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe "NewsmastMastodon Api V1 Patchwork AlttextSettings", type: :request do
  it "PATCH /api/v1/patchwork/alttext_settings toggles alttext_enabled" do
    require_host!
  end
end
