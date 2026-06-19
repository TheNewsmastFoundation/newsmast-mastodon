# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.5.11] - 2026-06-15

### Fixed

- Resolved single-gem sync regressions in the consolidated engine.
- Fixed API V1 behavior across account, channel, timeline, settings, webhook,
    notification token, drafted status, and local-only post endpoints.
- Aligned search indexing and support layers (Chewy indexes, authentication/user
    preparation concerns, helper behavior, and spec/dummy routing harnesses).
