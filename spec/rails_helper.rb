# frozen_string_literal: true

require "spec_helper"

ENV["RAILS_ENV"] ||= "test"

# NOTE: The consolidated engine extends Mastodon host classes (Account, Status,
# User, Feed, FeedManager, PostStatusService, etc.). The dummy Rails app under
# `spec/dummy/` is intentionally minimal and cannot boot the full Mastodon
# application stack. Specs that exercise host classes are marked `pending` or
# `skip` until the host app integration harness is available. See
# CONSOLIDATION_PLAN.md Phases 13-14.
require File.expand_path("dummy/config/environment", __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require "factory_bot_rails"
require "shoulda/matchers"
require "database_cleaner/active_record"
require "webmock/rspec"
require "vcr"
require "faker"

# Ensure any pending migrations from the engine are run against the dummy DB.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  warn e.to_s.strip
  # Pending specs won't execute migrations; swallow so the suite still loads.
end

# Load all support files (shared contexts, shared examples, helpers).
Dir[NewsmastMastodon::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
end

RSpec.configure do |config|
  config.fixture_paths = [NewsmastMastodon::Engine.root.join("spec/fixtures").to_s]
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation) if ActiveRecord::Base.connected?
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::ConnectionNotEstablished
    # Dummy DB may not exist yet; pending specs can still load.
  end

  config.around do |example|
    if ActiveRecord::Base.connected?
      DatabaseCleaner.cleaning { example.run }
    else
      example.run
    end
  end
end
