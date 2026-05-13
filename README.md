# newsmast_mastodon

`newsmast_mastodon` is a consolidated Rails engine that extends a Mastodon
host app with Newsmast features across accounts, content filtering,
conversations, custom feeds, local-only posts, posting workflows, and timeline
behavior.

## What this gem adds

- API endpoints under `api/v1` for Newsmast account and feed workflows
- Draft status APIs and publish workflow
- Local-only post settings support
- Feed and timeline extensions (including custom timeline endpoints)
- Account and notification-related enhancements
- Host-app concern/service prepends for Mastodon models and services
- Install task for Chewy indexes and frontend override files

## Installation

Add the gem to your Mastodon host app:

```ruby
gem "newsmast_mastodon"
```

Install dependencies:

```bash
bundle install
```

Run database migrations (the engine appends its own migrations to the host app):

```bash
bin/rails db:migrate
```

Install Chewy indexes and frontend overrides into the host app:

```bash
bin/rails newsmast_mastodon:install
```

If frontend files are copied/updated, rebuild frontend assets in the host app:

```bash
yarn build:development
# or
yarn build:production
```

## Compatibility

- Ruby: `>= 3.1.0`
- Rails: `>= 7.1`, `< 9.0`
- Host app: Mastodon-based Rails application

This repository does not pin a specific Mastodon release in its dependencies,
so compatibility should be validated against your target Mastodon version.

## Runtime behavior

- The engine mounts itself at `/` in the host app.
- The engine prepends/includes Newsmast concerns and overrides into Mastodon
  classes during `to_prepare`.
- The engine appends gem migrations to the host migration path automatically.
- If Ghost/WordPress environment variables are present, related hosts are
  allowlisted in `config.hosts`.

## Example endpoints

The engine defines multiple `api/v1` routes, including:

- `POST /api/v1/drafted_statuses`
- `POST /api/v1/drafted_statuses/:id/publish`
- `GET /api/v1/timelines/:username/feed`
- `GET /api/v1/local_only_posts/getLocalOnlySetting`

See `config/routes.rb` for the full route list.

## Development

Set up and run checks:

```bash
bin/setup
bundle exec rspec
bundle exec rubocop
```

Contribution process and standards are documented in `CONTRIBUTING.md`.

## Changelog

See `CHANGELOG.md` for release notes.

## License

This project is licensed under the GNU Affero General Public License v3.0.
See `LICENSE.txt` for details.
