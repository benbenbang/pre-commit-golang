#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go critic analysis failed.\n"
  exit 1
}

if ! command -v gocritic &> /dev/null; then
  printf "gocritic not installed or available in the PATH\n" >&2
  printf "please check https://github.com/go-critic/go-critic\n" >&2
  exit 1
fi

failed=false
for file in "$@"; do
  if ! gocritic check "$file" 2>&1; then
    failed=true
  fi
done

# Check if any file failed the gocritic check
if [[ $failed == "true" ]]; then
  fail
fi

printf "Go critic analysis completed successfully.\n"
