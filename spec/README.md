# Test suite (RSpec)

This engine is tested with [RSpec](https://rspec.info/).

## Running specs

```bash
bundle install
cd spec/dummy && bundle exec rails db:create db:migrate RAILS_ENV=test && cd -
bundle exec rspec
```

## Structure

- `spec/spec_helper.rb` — minimal config (loaded via `.rspec`)
- `spec/rails_helper.rb` — loads the dummy Rails app, FactoryBot, DatabaseCleaner, WebMock, VCR, Shoulda Matchers
- `spec/dummy/` — minimal Rails application (PostgreSQL) that mounts the engine
- `spec/support/` — shared contexts and shared examples
- `spec/factories/` — FactoryBot factories for all `NewsmastMastodon::*` models
- `spec/models/`, `spec/services/`, `spec/workers/`, `spec/serializers/`, `spec/validators/`, `spec/helpers/`, `spec/mailers/` — unit specs
- `spec/requests/`, `spec/routing/`, `spec/integration/` — integration specs

## Host dependency notice

This engine extends Mastodon host classes (`Account`, `Status`, `User`,
`Feed`, `FeedManager`, `PostStatusService`, …). The dummy app intentionally
does **not** embed the full Mastodon codebase. Specs that exercise host-class
behaviour are currently marked `pending`. They become runnable once the host harness is added
or when specs are executed against the real host Mastodon app that mounts
`newsmast_mastodon`.
