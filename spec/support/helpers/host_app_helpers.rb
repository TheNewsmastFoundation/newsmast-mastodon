# frozen_string_literal: true

# Helpers to detect whether the Mastodon host application is available in the
# current spec environment. The engine's dummy app cannot boot the full Mastodon
# stack, so specs that depend on host classes (Account, Status, User, Feed, etc.)
# guard on these helpers and mark themselves `pending` instead of `skip`.

module HostAppHelpers
  module_function

  def mastodon_host_loaded?
    %w[Account Status User MediaAttachment Feed FeedManager].all? do |const|
      Object.const_defined?(const)
    end
  end

  def require_host!
    return if mastodon_host_loaded?

    pending "Mastodon host integration required — see CONSOLIDATION_PLAN.md Phases 13-14"
  end
end

RSpec.configure do |config|
  config.include HostAppHelpers

  config.before(:each, :host_app) do
    require_host!
  end
end
