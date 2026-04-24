# frozen_string_literal: true

# Shared contexts that assume the Mastodon host application is loaded.
# In the current minimal dummy app these will short-circuit via `pending`
# blocks in individual specs, but the contexts remain authored so they can
# be used unchanged once the host harness is wired up.

RSpec.shared_context "authenticated_user" do
  let(:user) do
    pending("requires Mastodon host User/Account classes — see CONSOLIDATION_PLAN.md Phase 14")
    nil
  end
  let(:account) { user&.account }
  let(:token)   { nil }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
end

RSpec.shared_context "admin_user" do
  include_context "authenticated_user"

  let(:admin_role) do
    pending("requires Mastodon UserRole — see CONSOLIDATION_PLAN.md Phase 14")
    nil
  end
end

RSpec.shared_context "community_with_admins" do
  let(:community) do
    pending("requires Mastodon Account to seed CommunityAdmin — see CONSOLIDATION_PLAN.md Phase 13")
    nil
  end
  let(:community_admins) { [] }
end
