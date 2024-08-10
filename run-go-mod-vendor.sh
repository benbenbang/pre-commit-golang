#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Vendor directory differs. Please re-add it to your commit.\n"
  exit 1
}

go mod vendor

if ! git diff --exit-code vendor &> /dev/null; then
  fail
fi

printf "Vendor directory is up to date.\n"
