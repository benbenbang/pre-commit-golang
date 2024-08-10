#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go generate failed.\n"
  exit 1
}

if [ $# -eq 0 ]; then
  printf "No arguments supplied. Please provide the packages or directories to run go generate on.\n"
  exit 1
fi

# Run go generate on each provided argument
echo "$@" | xargs -n1 go generate || fail

printf "Go generate completed successfully.\n"
