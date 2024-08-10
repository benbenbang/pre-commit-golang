#!/usr/bin/env bash

set -euo pipefail

IFS=' ' read -ra args <<< "${1:-}"

# Run the go test command
if ! go test "${args[@]}" ./...; then
  echo "Go unit tests failed."
  exit 1
fi

echo "All Go unit tests passed successfully."
