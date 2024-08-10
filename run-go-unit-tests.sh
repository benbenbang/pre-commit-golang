#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go unit tests failed.\n"
  exit 1
}

# Find all directories containing Go files, excluding vendor and hidden directories
DIRS=$(find . -type f -name "*.go" -not -path "*/vendor/*" -not -path "*/.*/*" | xargs -n1 dirname | sort -u)

for dir in ${DIRS}; do
  printf "Running tests in %s\n" "$dir"
  if ! go test -v "./${dir}/..."; then
    fail
  fi
done

printf "All Go unit tests passed successfully.\n"
