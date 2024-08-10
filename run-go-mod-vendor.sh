#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Vendor directory differs. Please re-add it to your commit.\n"
  exit 1
}

printf "Running go mod vendor in .\n"
vendor_output=$(go mod vendor 2>&1)
vendor_status=$?

if [[ $vendor_status -ne 0 && $vendor_output != *"no dependencies to vendor"* ]]; then
  printf "%s\n" "$vendor_output"
  fail
fi

if [[ $vendor_output == *"no dependencies to vendor"* ]]; then
  printf "No dependencies to vendor. Skipping vendor check.\n"
  exit 0
fi

if ! git diff --quiet vendor; then
  fail
fi

printf "Vendor directory is up to date.\n"
