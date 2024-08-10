#!/usr/bin/env bash

set -euo pipefail  # Exit immediately if a command exits with a non-zero status, and catch unset variables.

fail() {
  printf "go.mod or go.sum differs. Please re-add it to your commit.\n"
  exit 1
}

# Run go mod tidy
go mod tidy -v "$@" || exit 2

# Check for changes in go.mod or go.sum
if ! git diff --exit-code go.* &> /dev/null; then
  fail
fi

printf "go.mod and go.sum are up to date.\n"
