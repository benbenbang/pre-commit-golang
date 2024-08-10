#!/usr/bin/env bash

set -euo pipefail

fail() {
  echo "Golangci-lint failed."
  exit 1
}

if ! command -v golangci-lint &> /dev/null; then
  echo "golangci-lint not installed or available in the PATH"
  echo "please check https://golangci-lint.run/usage/install/"
  exit 1
fi

if golangci-lint run "$@"; then
  echo "Golangci-lint completed successfully."
else
  fail
fi
