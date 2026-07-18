#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Building" go build ./... || {
  printf 'Go build failed.\n'
  exit 1
}

printf "Go build succeeded for all modules\n"
