#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR="$ROOT_DIR/docs"

if command -v newman >/dev/null 2>&1; then
  NEWMAN_BIN=(newman)
elif command -v npx >/dev/null 2>&1; then
  NEWMAN_BIN=(npx newman)
else
  echo "newman or npx is required" >&2
  exit 1
fi

ENV_FILE="${POSTMAN_ENV_FILE:-$ROOT_DIR/tmp/newman.generated.env.json}"
AUTO_SETUP="${AUTO_SETUP:-1}"

if [[ "$AUTO_SETUP" == "1" ]]; then
  ruby "$ROOT_DIR/script/api/postman_setup.rb"
fi

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Postman environment file not found: $ENV_FILE" >&2
  exit 1
fi

collections=(
  "$DOCS_DIR/accounts-api.postman_collection.json"
  "$DOCS_DIR/conversations-api.postman_collection.json"
  "$DOCS_DIR/custom_feeds-api.postman_collection.json"
  "$DOCS_DIR/local_only_posts-api.postman_collection.json"
  "$DOCS_DIR/posts-api.postman_collection.json"
  "$DOCS_DIR/content_filters-api.postman_collection.json"
)

failed=0
for collection in "${collections[@]}"; do
  echo "Running $(basename "$collection")"
  if [[ ! -s "$collection" ]]; then
    echo "  skipped (missing or empty)"
    continue
  fi

  if ! "${NEWMAN_BIN[@]}" run "$collection" --environment "$ENV_FILE" --reporters cli; then
    failed=1
  fi
  echo
  echo "----"
  echo

done

if [[ "$failed" -ne 0 ]]; then
  echo "One or more collections failed"
  exit 1
fi

echo "All collections passed"
