#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"
partition_go_hook_arguments "$@"

run_in_selected_go_modules "Building" go build "${HOOK_ARGS[@]}" ./... || {
  printf 'Go build failed.\n'
  exit 1
}

printf "Go build succeeded for all modules\n"
