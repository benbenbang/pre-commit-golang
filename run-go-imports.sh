#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go imports failed\n"
  exit 1
}

if ! command -v goimports &> /dev/null; then
  printf "goimports not installed or available in the PATH\n" >&2
  printf "please check https://pkg.go.dev/golang.org/x/tools/cmd/goimports\n" >&2
  exit 1
fi

DIR=${1:-.}

output=$(goimports -l -w "$DIR") || fail
printf "%s\n" "$output"

if [[ -z "$output" ]]; then
  printf "All imports are correctly formatted\n"
else
  fail
fi
