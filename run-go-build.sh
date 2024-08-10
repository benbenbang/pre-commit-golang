#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go build failed\n"
  exit 1
}

# Find all directories containing go.mod files
MOD_DIRS=$(find . -name go.mod -exec dirname {} \;)

for dir in ${MOD_DIRS}; do
  printf "Building in %s\n" "$dir"
  (cd "$dir" && go build ./... ) || fail
done

printf "Go build succeeded for all modules\n"
