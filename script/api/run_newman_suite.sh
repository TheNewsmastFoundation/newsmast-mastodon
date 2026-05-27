#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOCS_DIR="$ROOT_DIR/docs"
REPORT_DIR="$ROOT_DIR/tmp/newman-reports"
COMBINED_COLLECTION="$DOCS_DIR/newsmast-api.postman_collection.json"

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

ruby "$ROOT_DIR/script/api/build_combined_api_docs.rb"

if [[ "$AUTO_SETUP" == "1" ]]; then
  POSTMAN_ENV_OUTPUT_FILE="$ENV_FILE" ruby "$ROOT_DIR/script/api/postman_setup.rb"
fi

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Postman environment file not found: $ENV_FILE" >&2
  exit 1
fi

failed=0
rm -rf "$REPORT_DIR"
mkdir -p "$REPORT_DIR"

report_json="$REPORT_DIR/newsmast-api.json"

echo "Running $(basename "$COMBINED_COLLECTION")"
if [[ ! -s "$COMBINED_COLLECTION" ]]; then
  echo "Combined Postman collection not found: $COMBINED_COLLECTION" >&2
  exit 1
fi

run_newman() {
  if [[ "${SUPPRESS_NODE_DEPRECATION:-1}" == "1" ]]; then
    NODE_NO_WARNINGS=1 "${NEWMAN_BIN[@]}" run "$COMBINED_COLLECTION" --environment "$ENV_FILE" --reporters cli,json --reporter-json-export "$report_json"
  else
    "${NEWMAN_BIN[@]}" run "$COMBINED_COLLECTION" --environment "$ENV_FILE" --reporters cli,json --reporter-json-export "$report_json"
  fi
}

if ! run_newman; then
  failed=1
fi

ruby "$ROOT_DIR/script/api/summarize_newman_report.rb"

if [[ "$failed" -ne 0 ]]; then
  echo "One or more collections failed"
  exit 1
fi

echo "All collections passed"
