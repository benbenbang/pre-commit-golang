#!/usr/bin/env bash

set -euo pipefail

if ! command -v golangci-lint &> /dev/null; then
  echo "golangci-lint not installed or available in the PATH"
  echo "please check https://golangci-lint.run/usage/install/"
  exit 1
fi

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Running golangci-lint" golangci-lint run "$@" || {
  printf 'Golangci-lint failed.\n'
  exit 1
}

printf 'Golangci-lint completed successfully.\n'
