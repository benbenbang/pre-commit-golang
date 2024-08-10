#!/usr/bin/env bash

set -euo pipefail

report() {
  printf "Go imports completed.\n"
  if [[ -n "$1" ]]; then
    printf "The following files have been modified:\n"
    printf "%s\n" "$1"
  else
    printf "All imports are correctly formatted.\n"
  fi
}

DIR=${1:-.}

output=$(goimports -l -w "$DIR") || {
  printf "goimports command failed\n"
  exit 1
}

report "$output"
