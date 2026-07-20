#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"
partition_go_hook_arguments "$@"

run_in_selected_go_modules "Running go vet" go vet "${HOOK_ARGS[@]}" ./... || {
  printf 'Go vet failed for one or more modules.\n'
  exit 1
}

printf "Go vet succeeded for all packages.\n"
