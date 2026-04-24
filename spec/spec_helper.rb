# frozen_string_literal: true

# SimpleCov must be required before any application code so it can track
# line coverage for the whole engine.
require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/test/"
  minimum_coverage 0 # bump once real specs land (target: 80)
end

require "newsmast_mastodon"

RSpec.configure do |config|
  # Prefer the non-monkey-patched syntax.
  config.disable_monkey_patching!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.order = :random
  Kernel.srand config.seed
end
