#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Running tests" go test -v ./... || {
  printf 'Go unit tests failed.\n'
  exit 1
}

printf "All Go unit tests passed successfully.\n"
