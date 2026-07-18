#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Running go mod tidy" go mod tidy -v "$@" || {
  printf 'go mod tidy failed.\n'
  exit 1
}

printf 'go.mod and go.sum files are tidy.\n'
