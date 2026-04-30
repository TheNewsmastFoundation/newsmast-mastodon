# frozen_string_literal: true
#
# Skeleton spec generated from CONSOLIDATION_PLAN.md Phase 13.
# Every example is `skip`ped until the Mastodon host harness is available.
# Remove the `skip` and implement the expectation once the host is loaded.
require "rails_helper"

RSpec.describe NewsmastMastodon::Concerns::MediaAttachmentConcern, type: :model do
  it "#can_generate_alt? when ALT_TEXT_ENABLED and content type is valid" do
    require_host!
  end

  it "#is_valid_content_type? matches IMAGE_ALLOW_TYPES" do
    require_host!
  end

  it "after_save :call_generate_alt_text_worker enqueues worker when enabled" do
    require_host!
  end
end
