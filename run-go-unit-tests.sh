#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"
partition_go_hook_arguments "$@"

run_in_selected_go_modules "Running tests" go test -v "${HOOK_ARGS[@]}" ./... || {
  printf 'Go unit tests failed.\n'
  exit 1
}

printf "All Go unit tests passed successfully.\n"
