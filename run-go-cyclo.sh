#!/usr/bin/env bash

set -euo pipefail  # Exit immediately if a command exits with a non-zero status, and catch unset variables.

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

# Check if any arguments are supplied
if [ $# -eq 0 ]; then
  printf "No arguments supplied\n"
  printf "Please add \`args: [-over=15]\` in your pre-commit config\n"
  exit 1
fi

# Execute gocyclo with provided arguments
if ! gocyclo "$@"; then
  fail
fi

printf "Go cyclomatic complexity analysis completed successfully.\n"
