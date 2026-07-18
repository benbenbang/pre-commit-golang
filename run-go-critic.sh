#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go critic analysis failed.\n"
  exit 1
}

if command -v go-critic >/dev/null 2>&1; then
  GO_CRITIC_BIN=go-critic
elif command -v gocritic >/dev/null 2>&1; then
  # Compatibility with go-critic releases before the executable was renamed.
  GO_CRITIC_BIN=gocritic
else
  printf "go-critic not installed or available in the PATH\n" >&2
  printf "please install it using: go install github.com/go-critic/go-critic/cmd/go-critic@latest\n" >&2
  exit 1
fi

go_files=()
for file in "$@"; do
  [[ $file == *.go && -f $file && $file != */vendor/* ]] && go_files+=("$file")
done

if ((${#go_files[@]} == 0)); then
  printf 'No Go files to analyze.\n'
  exit 0
fi

if ! "$GO_CRITIC_BIN" check "${go_files[@]}"; then
  fail
fi

printf "Go critic analysis completed successfully.\n"
