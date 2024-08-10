#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Linting failed for one or more packages.\n"
  exit 1
}

if ! command -v staticcheck &> /dev/null; then
  printf "staticcheck not installed or available in the PATH\n" >&2
  printf "please install it using: go install honnef.co/go/tools/cmd/staticcheck@latest\n" >&2
  exit 1
fi

# Find all directories containing go.mod files
MOD_DIRS=$(find . -name go.mod -exec dirname {} \;)

for dir in ${MOD_DIRS}; do
  printf "Running staticcheck in %s\n" "$dir"
  (cd "$dir" && staticcheck ./...) || fail
done

printf "Staticcheck completed successfully for all packages.\n"
