#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go generate failed.\n"
  exit 1
}

# Find all directories containing Go files, excluding vendor and hidden directories
GO_DIRS=$(find . -type f -name "*.go" -not -path "*/vendor/*" -not -path "*/.*/*" | xargs -n1 dirname | sort -u)

if [[ -z "${GO_DIRS}" ]]; then
  printf "No Go directories found.\n"
  exit 0
fi

for dir in ${GO_DIRS}; do
  printf "Running go generate in %s\n" "$dir"
  (cd "$dir" && go generate ./...) || fail
done

printf "Go generate completed successfully in all directories.\n"
