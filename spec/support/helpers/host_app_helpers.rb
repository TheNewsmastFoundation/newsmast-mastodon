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

  def mastodon_db_available?
    ActiveRecord::Base.connection.execute("SELECT 1")
    true
  rescue StandardError
    false
  end

  def require_host!
    return skip("Mastodon host integration required") unless mastodon_host_loaded?
    return if mastodon_db_available?

    skip "Mastodon host database is unavailable — start PostgreSQL for host-mode specs"
  end
end

RSpec.configure do |config|
  config.include HostAppHelpers

  config.before(:each, :host_app) do
    require_host!
  end
end
