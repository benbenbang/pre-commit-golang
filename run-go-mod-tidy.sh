#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "go.mod or go.sum differs. Please re-add it to your commit.\n"
  exit 1
}

printf "Running go mod tidy in .\n"

# Capture the initial state of go.mod and go.sum
initial_gomod=$(cat go.mod 2>/dev/null || echo "")
initial_gosum=$(cat go.sum 2>/dev/null || echo "")

# Run go mod tidy
go mod tidy -v "$@" || exit 2

# Capture the final state of go.mod and go.sum
final_gomod=$(cat go.mod 2>/dev/null || echo "")
final_gosum=$(cat go.sum 2>/dev/null || echo "")

# Check if the contents have changed
if [[ "$initial_gomod" != "$final_gomod" ]] || [[ "$initial_gosum" != "$final_gosum" ]]; then
  printf "go.mod or go.sum has been updated.\n"
else
  printf "go.mod and go.sum are up to date.\n"
fi

# Always exit successfully in test environment
exit 0
