# Gem Release Runbook

This is the living team runbook for releasing `newsmast_mastodon` to RubyGems.

Primary release mode in this repository:
- Tag-triggered CI publish via GitHub Actions.
- Trigger pattern: tags that match `v*`.

## 1. Prerequisites

1. You have push access to the repository.
2. RubyGems trusted publishing is configured for this repository.
3. Your local branch is up to date with `main`.
4. Working tree is clean before starting the release.
5. Commit and tag signing are configured for your Git identity.

Check:

```bash
git checkout main
git pull --ff-only origin main
git status
```

## 2. Versioning Policy (SemVer)

Use Semantic Versioning: `MAJOR.MINOR.PATCH`.

1. `PATCH` (x.y.Z): Bug fixes, small internal improvements, no public API break.
2. `MINOR` (x.Y.z): Backward-compatible feature additions.
3. `MAJOR` (X.y.z): Backward-incompatible changes.

Examples:

1. `0.1.0` -> `0.1.1` for fixes only.
2. `0.1.0` -> `0.2.0` for new features.
3. `0.1.0` -> `1.0.0` for first stable major milestone.

## 3. Files You Must Update

1. `lib/newsmast_mastodon/version.rb`
2. `CHANGELOG.md`

Do not manually edit version in `newsmast_mastodon.gemspec`; it reads from `NewsmastMastodon::VERSION`.

## 4. Preflight Checks

Run all checks before creating a release tag.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
bundle exec rake build
```

Optional API checks (if release touches API behavior):

```bash
bundle exec rake api:verify
bundle exec rake api:postman
bundle exec rake api:smoke
```

## 5. Release Procedure (Tag-Triggered CI)

Replace `X.Y.Z` with the target version.

1. Update version constant.

```bash
# edit file and set VERSION = "X.Y.Z"
$EDITOR lib/newsmast_mastodon/version.rb
```

2. Update changelog.

Update `CHANGELOG.md` by:
- Moving release-ready entries from `Unreleased` into `## [X.Y.Z] - YYYY-MM-DD`.
- Creating a new empty `Unreleased` section at the top for future changes.

3. Re-run preflight checks.

```bash
bundle exec rspec
bundle exec rubocop
bundle exec rake build
```

4. Commit release changes.

```bash
git add lib/newsmast_mastodon/version.rb CHANGELOG.md
git commit -S -m "chore(release): vX.Y.Z"
git push origin main
```

5. Create and push the release tag.

```bash
git tag -s vX.Y.Z -m "Release vX.Y.Z"
git push origin vX.Y.Z
```

If signing is not yet configured in your environment, set it up before release.

6. Monitor GitHub Actions publish run.

```bash
gh run list --workflow "Publish to RubyGems" --limit 5
gh run watch
```

Web UI fallback:
- Open Actions and check workflow `Publish to RubyGems` for tag `vX.Y.Z`.

## 6. Post-Release Verification

1. Confirm gem version is visible on RubyGems.
2. Verify install succeeds.

```bash
gem search newsmast_mastodon --remote
gem install newsmast_mastodon --version X.Y.Z
```

3. Confirm source tag exists on remote.

```bash
git ls-remote --tags origin | grep "refs/tags/vX.Y.Z$"
```

## 7. Rollback And Incident Playbooks

### A) Publish failed before gem was released

1. Inspect workflow logs and fix the root cause.
2. If tag is bad, delete and recreate tag after the fix.

```bash
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
```

Then repeat release tagging.

### B) Gem published but must be withdrawn

1. Yank the gem version from RubyGems.
2. Remove the bad tag.
3. Prepare a fixed version and release a new version.

```bash
gem yank newsmast_mastodon -v X.Y.Z
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
```

Note: yanked gems remain in index history; always publish a corrected follow-up version.

## 8. Troubleshooting

1. Workflow did not trigger:
- Ensure tag matches `v*` (for example `v0.2.0`).
- Ensure tag exists on remote: `git ls-remote --tags origin`.

2. RubyGems authentication error:
- Verify trusted publishing is configured on RubyGems for this repository.
- Confirm workflow has `permissions.id-token: write`.

3. Version mismatch during build:
- Confirm `lib/newsmast_mastodon/version.rb` has the intended version.
- Confirm tag and version match exactly (`vX.Y.Z` vs `X.Y.Z`).

## 9. Operator Checklist

Use this checklist for each release:

1. Branch updated and clean working tree.
2. Version bump in `lib/newsmast_mastodon/version.rb`.
3. Changelog updated in `CHANGELOG.md`.
4. Tests/lint/build pass.
5. Release commit merged to `main`.
6. Tag `vX.Y.Z` created and pushed.
7. Release commit and tag are signed.
8. Publish workflow passed.
9. RubyGems version verified.
