#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go formatting failed.\n"
  exit 1
}

if ! command -v gofmt &> /dev/null; then
  printf "gofmt not installed or available in the PATH\n" >&2
  exit 1
fi

# Run gofmt and capture the output
output=$(gofmt -l -w "$@") || fail
printf "%s\n" "$output"

if [[ -z "$output" ]]; then
  printf "All files are correctly formatted.\n"
else
  fail
fi
