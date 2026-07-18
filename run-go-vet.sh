#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Running go vet" go vet ./... || {
  printf 'Go vet failed for one or more modules.\n'
  exit 1
}

printf "Go vet succeeded for all packages.\n"
