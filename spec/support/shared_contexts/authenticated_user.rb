# frozen_string_literal: true

# Shared contexts that assume the Mastodon host application is loaded.
# In the current minimal dummy app these will short-circuit via `pending`
# blocks in individual specs, but the contexts remain authored so they can
# be used unchanged once the host harness is wired up.

RSpec.shared_context "authenticated_user" do
  let(:user)    { Fabricate(:user) }
  let(:account) { user.account }
  let(:token)   { Fabricate(:accessible_access_token, resource_owner_id: user.id, scopes: "read write") }
  let(:headers) { { "Authorization" => "Bearer #{token.token}" } }
end

RSpec.shared_context "admin_user" do
  include_context "authenticated_user"

  let(:user) { Fabricate(:admin_user) }
end

RSpec.shared_context "community_with_admins" do
  include_context "authenticated_user"

  let(:community)        { Fabricate(:newsmast_mastodon_community) }
  let(:community_admins) { [] }
end
