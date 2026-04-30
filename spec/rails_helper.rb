# frozen_string_literal: true

require "spec_helper"

ENV["RAILS_ENV"] ||= "test"

# Support two boot modes:
#
#   1. Standalone (gem's own Gemfile / dummy app) — default when running
#      `bundle exec rspec` from the gem root.  Loads the minimal dummy Rails app
#      and uses host-app stubs so specs can at least load.
#
#   2. Host-app mode (Mastodon's Gemfile) — used when running with
#      BUNDLE_GEMFILE=/path/to/mastodon/Gemfile. In this case Rails is already
#      (or will be) initialised by the host environment; we skip the dummy boot.

unless defined?(Rails) && Rails.application && Rails.application.initialized?
  require File.expand_path("dummy/config/environment", __dir__)
end

abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"

# factory_bot_rails is in the gem's own bundle; the Mastodon host bundle uses
# Fabrication instead — skip gracefully if neither factory_bot variant is present.
begin
  require "factory_bot_rails"
rescue LoadError
  begin
    require "factory_bot"
  rescue LoadError
    # Running under Mastodon host bundle which uses Fabrication; no factory_bot.
  end
end

require "shoulda/matchers"
require "database_cleaner/active_record"

# Load host-app stubs only in standalone mode (when Mastodon classes are absent).
require File.expand_path("support/mastodon_stubs", __dir__)

require "webmock/rspec"

begin
  require "vcr"
rescue LoadError
  # vcr not available in the Mastodon host bundle; VCR.configure is skipped below.
end

require "faker"

# Ensure any pending migrations from the engine are run against the current DB.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  warn e.to_s.strip
rescue ActiveRecord::NoDatabaseError, ActiveRecord::ConnectionNotEstablished
  # Dummy DB may not exist yet; pending specs can still load.
end

# Load all support files (shared contexts, shared examples, helpers).
Dir[NewsmastMastodon::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

if defined?(VCR)
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    config.configure_rspec_metadata!
    config.ignore_localhost = true
  end
end

RSpec.configure do |config|
  config.fixture_paths = [NewsmastMastodon::Engine.root.join("spec/fixtures").to_s]
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods if defined?(FactoryBot)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation) if ActiveRecord::Base.connected?
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::ConnectionNotEstablished
    # DB may not exist yet; pending specs can still load.
  end

  config.around do |example|
    if ActiveRecord::Base.connected?
      DatabaseCleaner.cleaning { example.run }
    else
      example.run
    end
  end
end
