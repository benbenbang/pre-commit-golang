#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go formatting failed.\n"
  exit 1
}

# Find all Go files, excluding vendor and hidden directories
FILES=$(find . -type f -name "*.go" ! -path "*/vendor/*" ! -path "*/.*/*")

# Check if any Go files were found
if [[ -z "${FILES}" ]]; then
  printf "No Go files found in the specified directory\n"
  exit 0
fi

# Run gofmt and capture the output
output=$(gofmt -l -w ${FILES}) || fail

# Check if there is any output indicating files were modified
if [[ -z "$output" ]]; then
  printf "All files are correctly formatted.\n"
else
  printf "The following files have been formatted:\n"
  printf "%s\n" "$output"
  # Don't fail the script if files were formatted
  printf "Go formatting completed successfully.\n"
fi
