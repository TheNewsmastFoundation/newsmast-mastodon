# Contributing to newsmast_mastodon

Thanks for your interest in improving `newsmast_mastodon`! This document
describes how to set up your environment, run the test suite, and submit
changes.

## Development setup

1. Clone the repository and `cd` into it.
2. Install dependencies and prepare the dummy app:

   ```bash
   bin/setup
   ```

3. Run the test suite to confirm your environment works:

   ```bash
   bundle exec rspec
   ```

4. Run the linter:

   ```bash
   bundle exec rubocop
   ```

## Making changes

1. Create a feature branch from `main`:

   ```bash
   git checkout -b feat/my-change
   ```

2. Make focused commits with descriptive messages (see below).
3. Ensure `rspec` and `rubocop` pass locally.
4. Update `CHANGELOG.md` under the `Unreleased` section.
5. Open a pull request against `main` and fill in the PR template.

## Coding standards

- Follow the rules in `.rubocop.yml` (inherits from `rubocop-rails-omakase`).
- Keep public APIs namespaced under `NewsmastMastodon::`.
- Prefer small, composable service objects over large controllers/models.
- Add or update specs for every behavior change.

## Commit message conventions

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<optional scope>): <short summary>

<optional body>

<optional footer>
```

Common types: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `chore`,
`build`, `ci`.

## Reporting bugs or requesting features

Please use the GitHub issue templates under `.github/ISSUE_TEMPLATE/`.
For security-sensitive issues, see [`SECURITY.md`](SECURITY.md) instead of
opening a public issue.
