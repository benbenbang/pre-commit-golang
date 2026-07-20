#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"
partition_go_hook_arguments "$@"

run_in_selected_go_modules "Running go generate" go generate "${HOOK_ARGS[@]}" ./... || {
  printf 'Go generate failed.\n'
  exit 1
}

printf "Go generate completed successfully in all directories.\n"
