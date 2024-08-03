#!/usr/bin/env bash

set -e

fail() {
  printf "Go build failed\n"
  exit 1
}

DIR=${1:-.}

FILES=$(go list ${DIR}/... | grep -v /vendor/) || fail

go build ${FILES} || fail

printf "Go build succeeded\n"
