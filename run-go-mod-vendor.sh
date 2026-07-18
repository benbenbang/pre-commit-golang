#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_go-hook-lib.sh"

run_in_go_modules "Running go mod vendor" go mod vendor || {
  printf 'go mod vendor failed.\n'
  exit 1
}

printf 'Vendor directories are up to date.\n'
