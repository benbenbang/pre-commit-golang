#!/usr/bin/env bash

set -euo pipefail  # Exit immediately if a command exits with a non-zero status, and catch unset variables.

fail() {
  printf "Go formatting failed.\n"
  exit 1
}

# Ensure gofmt is installed and available in the PATH
if ! command -v gofmt &> /dev/null; then
  printf "gofmt not installed or available in the PATH\n" >&2
  exit 1
fi

# Find all Go files, excluding the vendor directory
FILES=$(find . -type f -name "*.go" ! -path "*/vendor/*")

# Check if any Go files were found
if [[ -z "${FILES}" ]]; then
  printf "No Go files found in the specified directory\n"
  exit 0
fi

# Run gofmt and capture the output
output=$(gofmt -l -w ${FILES}) || fail
printf "%s\n" "$output"

# Check if there is any output indicating files were modified
if [[ -z "$output" ]]; then
  printf "All files are correctly formatted.\n"
else
  fail
fi
