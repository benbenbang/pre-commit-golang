#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Golangci-lint failed.\n"
  exit 1
}

if ! command -v golangci-lint &> /dev/null; then
  printf "golangci-lint not installed or available in the PATH\n" >&2
  printf "please check https://golangci-lint.run/usage/install/\n" >&2
  exit 1
fi

if ! golangci-lint run "$@"; then
  fail
fi

printf "Golangci-lint completed successfully.\n"
