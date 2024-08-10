#!/usr/bin/env bash

set -euo pipefail

fail() {
  printf "Go cyclomatic complexity analysis failed.\n"
  exit 1
}

# Ensure gocyclo is installed and available in the PATH
if ! command -v gocyclo &> /dev/null; then
  printf "gocyclo not installed or available in the PATH\n" >&2
  printf "please check https://github.com/fzipp/gocyclo\n" >&2
  exit 1
fi

# Default threshold
THRESHOLD=15

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -over=*)
      THRESHOLD="${1#*=}"
      shift
      ;;
    *)
      ARGS+=("$1")
      shift
      ;;
  esac
done

# If no directory is specified, use current directory
if [ ${#ARGS[@]} -eq 0 ]; then
  ARGS+=(".")
fi

# Execute gocyclo with provided arguments
if ! gocyclo -over $THRESHOLD "${ARGS[@]}"; then
  fail
fi

printf "Go cyclomatic complexity analysis completed successfully.\n"
