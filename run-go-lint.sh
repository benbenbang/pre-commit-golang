#!/usr/bin/env bash

set -euo pipefail

if ! command -v staticcheck &> /dev/null; then
  printf "staticcheck not installed or available in the PATH\n" >&2
  printf "please install it using: go install honnef.co/go/tools/cmd/staticcheck@latest\n" >&2
  exit 1
fi

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Running staticcheck" staticcheck ./... || {
  printf 'Linting failed for one or more modules.\n'
  exit 1
}

printf "Staticcheck completed successfully for all packages.\n"
