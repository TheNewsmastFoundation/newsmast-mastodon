# newsmast-mastodon

[![CI](https://github.com/TheNewsmastFoundation/newsmast-mastodon/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/TheNewsmastFoundation/newsmast-mastodon/actions/workflows/ci.yml)
[![Security](https://github.com/TheNewsmastFoundation/newsmast-mastodon/actions/workflows/security.yml/badge.svg?branch=main)](https://github.com/TheNewsmastFoundation/newsmast-mastodon/actions/workflows/security.yml)
[![Mastodon](https://img.shields.io/badge/Mastodon-4.6.5-6364FF?logo=mastodon&logoColor=white)](https://github.com/mastodon/mastodon/releases/tag/v4.6.5)
[![License: AGPL-3.0](https://img.shields.io/badge/license-AGPL--3.0--only-blue)](LICENSE.txt)

A Rails engine that extends a [Mastodon](https://github.com/mastodon/mastodon)
server with the features behind the **Newsmast Apps for Change** mobile apps
and the [Newsmast Dashboard](https://github.com/TheNewsmastFoundation/newsmast-dashboard):
content channels, content filters, drafts, push notifications, account
management and more.

Install it into an existing Mastodon server and it adds these features at
runtime, so you don't need to maintain a fork.

## Features

- **Timelines:** per-account custom feeds, a "For You" timeline, and an
  instances timeline that combines home with selected relay domains.
- **Posting:** drafted statuses (create, edit, publish later), local-only
  posts, long posts, and link previews.
- **Moderation and content filters:** banned statuses, tags and accounts,
  domain and username block lists, and content filter keywords.
- **Notifications:** Firebase (FCM) push with per-device tokens and mute
  settings, cross-instance push from a trusted partner server, and branded
  email templates.
- **Accounts:** OTP-based email verification and password reset, email
  change, account deletion, alt-text and email notification settings, and
  automatically following default accounts.
- **Community features:** status reactions, conversation helpers, a boost bot
  and channel reblogging, and custom relays.
- **Mobile deep links:** `apple-app-site-association` and `assetlinks.json`
  served from `/.well-known`.

See [`docs/newsmast-api-list.md`](docs/newsmast-api-list.md) for the full API
list, or import the
[Postman collection](docs/newsmast-api.postman_collection.json).

## Compatibility

The gem uses **compatibility-first versioning**: `X.Y.Z.N`, where `X.Y.Z` is
the Mastodon version it targets and `N` is the gem patch level for that
Mastodon line. Install the version that matches your Mastodon server.

| Gem version | Mastodon | Ruby | Rails |
| --- | --- | --- | --- |
| `4.6.5.x` | 4.6.5 | >= 3.3, < 4.1 | ~> 8.1 |
| `4.6.3.x` | 4.6.3 | >= 3.3, < 4.1 | ~> 8.1 |
| `4.5.11` | 4.5.11 | see [CHANGELOG](CHANGELOG.md#4511---2026-06-15) | see [CHANGELOG](CHANGELOG.md#4511---2026-06-15) |

Release notes for each version are in [`CHANGELOG.md`](CHANGELOG.md).

## Installation

Run these steps from the root of your Mastodon application.

1. Add the gem to Mastodon's `Gemfile`, pinned to the version that matches
   your Mastodon release:

   ```ruby
   gem "newsmast_mastodon", "4.6.5.1"
   ```

2. Install it and copy the gem's Chewy indexes and frontend overrides into the
   host app:

   ```bash
   bundle install
   bin/rails newsmast_mastodon:install
   ```

3. Run the migrations and rebuild the frontend:

   ```bash
   bin/rails db:migrate
   yarn build:production
   ```

4. Set the environment variables for the features you use (see
   [Configuration](#configuration)), then restart the web, Sidekiq and
   streaming processes.

New servers can also create the database from Mastodon's schema
(`bin/rails db:setup`, `db:prepare` or `mastodon:setup`). The gem runs its own
migrations right after the schema is loaded, so its tables and columns are
created either way.

The engine mounts its routes automatically, so you don't need to edit
`config/routes.rb`. For a full deployment guide, see the
[installation docs](https://github.com/TheNewsmastFoundation/documentation/tree/main/newsmast-mastodon).

### Upgrading

To move to a new Mastodon version, bump Mastodon and the gem together:

1. Change the version pin in the `Gemfile`, then run
   `bundle update newsmast_mastodon`.
2. Run `bin/rails newsmast_mastodon:install` again, because the frontend
   overrides change between releases.
3. Run `bin/rails db:migrate`, rebuild assets, and restart.

Check the [`CHANGELOG.md`](CHANGELOG.md) entry for each version you skip, and
the [release process](RELEASE.md) for upgrade notes.

## Configuration

Every feature is configured with environment variables, and most are off
until you set them. See
[`docs/configuration/environment-variables.md`](docs/configuration/environment-variables.md)
for the full reference, and the hosted
[configuration guide](https://github.com/TheNewsmastFoundation/documentation/blob/main/newsmast-mastodon/configuration.md).

## How the gem overrides Mastodon

The gem is a standard Rails engine. It changes Mastodon's behavior at runtime by:

- prepending modules into Mastodon services, serializers, validators and
  controllers (see
  [`config/initializers/prepend_concerns.rb`](config/initializers/prepend_concerns.rb));
- including model concerns into `Account`, `Status`, `User` and other host
  models;
- shipping its own migrations, frontend components and API controllers, which
  mount onto the host.

This gives every Mastodon host the same behavior that used to be maintained as
inline patches in a fork. `bin/check-override-drift` checks that the vendored
frontend overrides still match a given Mastodon checkout.

## Documentation

| Topic | Where |
| --- | --- |
| Environment variables | [`docs/configuration/environment-variables.md`](docs/configuration/environment-variables.md) |
| API list and Postman collection | [`docs/newsmast-api-list.md`](docs/newsmast-api-list.md) |
| Local development and testing | [`docs/development/testing-and-local-services.md`](docs/development/testing-and-local-services.md) |
| API validation and system tests | [`docs/testing/api-validation-and-system-testing.md`](docs/testing/api-validation-and-system-testing.md) |
| CI jobs | [`docs/ci/jobs.md`](docs/ci/jobs.md) |
| Troubleshooting | [`docs/troubleshooting/common-issues.md`](docs/troubleshooting/common-issues.md) |
| Mastodon upgrade guide (maintainers) | [`docs/internal/mastodon-upgrade/GUIDE.md`](docs/internal/mastodon-upgrade/GUIDE.md) |

## Development

```bash
bin/setup --skip-server   # install dependencies and prepare the dummy app
bundle exec rspec         # run the test suite
bundle exec rubocop       # lint
bundle exec rake api:verify  # check routes, controllers and Postman docs are in sync
```

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the full workflow.

## Contributing and community

- [Contributing guide](CONTRIBUTING.md)
- [Governance](GOVERNANCE.md) and [maintainers](MAINTAINERS.md)
- [Getting support](SUPPORT.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- **Security issues:** please report privately as described in
  [`SECURITY.md`](SECURITY.md). Don't open a public issue.

## License

Copyright © Patchwork Hub and contributors. Licensed under the
[GNU Affero General Public License v3.0 only](LICENSE.txt). This gem extends
and includes code derived from Mastodon; see [`NOTICE`](NOTICE) for
attribution.
