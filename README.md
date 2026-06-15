# newsmast_mastodon

`newsmast_mastodon` is a Rails engine that extends a Mastodon
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

Add the gem to your Mastodon host app with a strict version constraint:

```ruby
gem "newsmast_mastodon", "4.5.11"
```

**Important:** Do NOT use flexible version constraints like `~> 4.5` or `>= 4.5.11`, as these allow minor/patch version bumps that may not be compatible with your Mastodon version. Always pin to the exact version (e.g., `"4.5.11"`).

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
bundle install
bundle exec rspec
bundle exec rubocop
```

### Standalone Test Run With Docker Services

Use Docker only for infrastructure (PostgreSQL, Redis, Elasticsearch), while
running the Rails app and specs directly on your machine.

From your workspace root, start services:

```bash
docker compose up -d db redis es
```

From `newsmast_mastodon`, run specs against those services:

```bash
export DATABASE_HOST=127.0.0.1
export DATABASE_PORT=5432
export DATABASE_USER=postgres
export DATABASE_PASSWORD=postgres
export REDIS_HOST=127.0.0.1
export REDIS_PORT=6379
export ES_ENABLED=true
export ES_HOST=127.0.0.1
export ES_PORT=9200

bundle exec rspec --format progress
```

Optional cleanup:

```bash
docker compose down
```

Note: `RAILS_ENV=test bin/rails app:db:prepare` can fail if duplicate migration
names exist in the consolidated migration set. In that case, run specs directly
as above until migration naming conflicts are resolved.

## API validation and system testing

This repository includes a full API verification workflow for the consolidated
gem routes and a combined Postman collection.

### 1) Verify route/controller/doc sync

```bash
ruby script/api/verify_routes_and_docs.rb
# or
bundle exec rake api:verify
```

This checks:

- every expected route has a matching controller action
- every route appears in the combined Postman collection under `docs/`
- every Postman entry maps to a real route

### 2) Run the combined Postman collection with Newman

```bash
BASE_URL=http://localhost:3000 \
ACCESS_TOKEN=... \
bash script/api/run_newman_suite.sh

# or
BASE_URL=http://localhost:3000 ACCESS_TOKEN=... bundle exec rake api:postman
```

The runner does a setup step first (`script/api/postman_setup.rb`) to generate
`tmp/newman.generated.env.json`, including dynamic IDs such as:

- `account_id`
- `username`
- `drafted_status_id` (if draft creation succeeds)
- `relay_id` (if relay creation succeeds)

You can disable auto setup and use a custom environment file:

```bash
AUTO_SETUP=0 POSTMAN_ENV_FILE=script/api/newman.env.staging.template.json \
bash script/api/run_newman_suite.sh
```

Templates for local and staging are available in `script/api/`.

### 3) Run request-spec smoke layer

```bash
bash script/api/run_rspec_smoke.sh
# or
bundle exec rake api:smoke
```

### 4) Run complete check sequence

```bash
BASE_URL=http://localhost:3000 ACCESS_TOKEN=... bundle exec rake api:full_check
```

Contribution process and standards are documented in `CONTRIBUTING.md`.

## Changelog

See `CHANGELOG.md` for release notes.

## License

This project is licensed under the GNU Affero General Public License v3.0.
See `LICENSE.txt` for details.
