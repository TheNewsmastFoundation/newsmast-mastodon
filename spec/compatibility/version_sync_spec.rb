# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/newsmast_mastodon/version"

# Keeps the gem's four version surfaces in lock-step. Version skew between these
# is a silent upgrade hazard: the gemspec metadata is what the host runtime
# compatibility assertion checks against, the README is what humans pin from,
# and the CHANGELOG is the audit trail. They must all agree with VERSION.
RSpec.describe "Version surfaces stay in sync" do
  ROOT = File.expand_path("../..", __dir__)

  let(:version) { NewsmastMastodon::VERSION }

  it "uses a valid SemVer string" do
    expect(version).to match(/\A\d+\.\d+\.\d+\z/)
  end

  it "matches mastodon_version_requirement in the gemspec" do
    gemspec = File.read(File.join(ROOT, "newsmast_mastodon.gemspec"))
    declared = gemspec[/mastodon_version_requirement"\]\s*=\s*"([^"]+)"/, 1]

    expect(declared).to eq(version),
      "gemspec mastodon_version_requirement (#{declared.inspect}) must equal " \
      "NewsmastMastodon::VERSION (#{version.inspect})."
  end

  it "matches the version pin documented in the README" do
    readme = File.read(File.join(ROOT, "README.md"))

    expect(readme).to include(%(gem "newsmast_mastodon", "#{version}")),
      "README install snippet must pin the current version #{version.inspect}."
  end

  it "has a matching CHANGELOG entry as the latest release" do
    changelog = File.read(File.join(ROOT, "CHANGELOG.md"))
    latest = changelog[/^##\s*\[(\d+\.\d+\.\d+)\]/, 1]

    expect(latest).to eq(version),
      "Latest released CHANGELOG entry (#{latest.inspect}) must match " \
      "NewsmastMastodon::VERSION (#{version.inspect}). Move entries out of " \
      "Unreleased when bumping the version."
  end
end
