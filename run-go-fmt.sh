#!/usr/bin/env bash

set -euo pipefail

files=()
for file in "$@"; do
  [[ $file == *.go && -f $file && $file != */vendor/* ]] && files+=("$file")
done

if ((${#files[@]} == 0)); then
  printf 'No Go files to format.\n'
  exit 0
fi

output=$(gofmt -l -w -- "${files[@]}") || {
  printf 'Go formatting failed.\n'
  exit 1
}

# Check if there is any output indicating files were modified
if [[ -z "$output" ]]; then
  printf "All files are correctly formatted.\n"
else
  printf "The following files have been formatted:\n"
  printf "%s\n" "$output"
  # Don't fail the script if files were formatted
  printf "Go formatting completed successfully.\n"
fi
