# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::PatchworkHelper, type: :helper do
  it "#patchwork_table_exists? detects the patchwork table" do
    require_host!
  end

  it "#patchwork_server_settings_exist? detects settings rows" do
    require_host!
  end

  it "#patchwork_community_admin_exist? detects admin rows" do
    require_host!
  end
end
