# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::LongPost::InstanceSerializerExtension, type: :serializer do
  it "reads max_characters from NewsmastMastodon::ServerSetting" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end

  it "falls back to 500 when setting is missing" do
    skip "pending Mastodon host harness — see CONSOLIDATION_PLAN.md Phase 13"
  end
end
