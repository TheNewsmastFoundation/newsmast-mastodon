# Releases

Each `newsmast_mastodon` release is a `v<version>` tag on `main` (for example
`v4.6.5.1`). The [release workflow](.github/workflows/release.yml) then runs
the tests, builds the gem, generates `SHA256SUMS` and a build provenance
attestation, and publishes to RubyGems.

- **What changed:** [`CHANGELOG.md`](CHANGELOG.md) is the source of truth for
  every version.
- **Published releases:** [GitHub Releases](https://github.com/TheNewsmastFoundation/newsmast-mastodon/releases)
  and [RubyGems](https://rubygems.org/gems/newsmast_mastodon).
- **How to cut a release (maintainers):** follow
  [`docs/internal/mastodon-upgrade/release.md`](docs/internal/mastodon-upgrade/release.md).
- **Moving to a new Mastodon version (maintainers):** follow the
  [upgrade guide](docs/internal/mastodon-upgrade/GUIDE.md) and record the run
  in [`docs/internal/mastodon-upgrade/reports/`](docs/internal/mastodon-upgrade/reports/README.md).

## Upgrading a server

The gem version must match your Mastodon version (`X.Y.Z` of the gem is the
Mastodon version), so upgrade Mastodon and the gem together.

1. Back up your database and media.
2. Upgrade Mastodon to the target version by following Mastodon's own
   release notes.
3. Update the pin in Mastodon's `Gemfile`, then install:

   ```bash
   bundle update newsmast_mastodon
   ```

4. Copy the gem's Chewy indexes and frontend overrides for the new version:

   ```bash
   RAILS_ENV=production bin/rails newsmast_mastodon:install
   ```

5. Run migrations and rebuild assets:

   ```bash
   RAILS_ENV=production bin/rails db:migrate
   RAILS_ENV=production bin/rails assets:precompile
   ```

6. Restart the web, Sidekiq and streaming services.
7. Confirm the loaded version:

   ```bash
   RAILS_ENV=production bin/rails runner 'puts NewsmastMastodon::VERSION'
   ```

To roll back, pin the previous gem version, run `bundle install` and
`bin/rails newsmast_mastodon:install` again, and restore the database backup
if the new release included migrations.

## Release notes template

Copy this into the GitHub Release body, filling it in from the matching
`CHANGELOG.md` section.

```markdown
## newsmast_mastodon vX.Y.Z.N

**Targets Mastodon:** X.Y.Z · **Ruby:** >= 3.3, < 4.1 · **Rails:** ~> 8.1

### Upgrade notes
- Migrations: yes / no
- Re-run `bin/rails newsmast_mastodon:install`: yes / no (frontend overrides or Chewy indexes changed)
- New or changed environment variables: none / list them
- Breaking changes: none / describe them, with migration steps

### Changes
<!-- Paste the Added / Changed / Fixed / Security sections from CHANGELOG.md -->

### Verification
- SHA256 checksums: `SHA256SUMS` attached to this release
- Build provenance: attested by the release workflow

**Full changelog:** https://github.com/TheNewsmastFoundation/newsmast-mastodon/compare/vPREVIOUS...vX.Y.Z.N
```
