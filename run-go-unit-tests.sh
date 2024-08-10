#!/usr/bin/env bash

set -euo pipefail  # Exit immediately if a command exits with a non-zero status, and catch unset variables.

fail() {
  printf "Go vet failed for one or more directories.\n"
  exit 1
}

DIR=${1:-.}

FILES=$(find "${DIR}" -type f -name "*.go" ! -path "*/vendor/*")

if [[ -z "${FILES}" ]]; then
  printf "No Go files found in the specified directory\n"
  exit 0
fi

DIRS=$(dirname ${FILES} | sort -u)

for dir in ${DIRS}; do
  if ! go vet "./${dir}"; then
    fail
  fi
done

printf "Go vet succeeded for all directories.\n"
