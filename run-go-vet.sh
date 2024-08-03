#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go vet failed for one or more directories.\n"
  exit 1
}

DIR=${1:-.}

PACKAGES=$(go list ${DIR}/... | grep -v /vendor/) || fail

for pkg in ${PACKAGES}; do
if ! go vet "${dir}"; then
  fail
fi
done

printf "Go vet succeeded for all packages.\n"
