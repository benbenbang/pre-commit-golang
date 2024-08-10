#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go critic analysis failed.\n"
  exit 1
}

if ! command -v gocritic &> /dev/null; then
  printf "gocritic not installed or available in the PATH\n" >&2
  printf "please install it using: go install github.com/go-critic/go-critic/cmd/gocritic@latest\n" >&2
  exit 1
fi

# Find all Go files, excluding vendor and hidden directories
GO_FILES=$(find . -type f -name "*.go" -not -path "*/vendor/*" -not -path "*/.*/*")

if [[ -z "${GO_FILES}" ]]; then
  printf "No Go files found.\n"
  exit 0
fi

# Run gocritic on all files
if ! gocritic check ${GO_FILES}; then
  fail
fi

printf "Go critic analysis completed successfully.\n"
