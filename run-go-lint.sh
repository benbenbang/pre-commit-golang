#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Linting failed for one or more files.\n"
  exit 1
}

if ! command -v golint &> /dev/null; then
  |oai:code-citation|
