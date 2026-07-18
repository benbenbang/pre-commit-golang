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

files=()
for file in "$@"; do
  [[ $file == *.go && -f $file && $file != */vendor/* ]] && files+=("$file")
done

if ((${#files[@]} == 0)); then
  printf 'No Go files to organize.\n'
  exit 0
fi

output=$(goimports -l -w -- "${files[@]}") || {
  printf "goimports command failed\n"
  exit 1
}

report "$output"
