#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go vet failed for one or more packages.\n"
  exit 1
}

# Find all directories containing go.mod files
MOD_DIRS=$(find . -name go.mod -exec dirname {} \;)

for dir in ${MOD_DIRS}; do
  printf "Running go vet in %s\n" "$dir"
  (cd "$dir" && go vet ./...) || fail
done

printf "Go vet succeeded for all packages.\n"
