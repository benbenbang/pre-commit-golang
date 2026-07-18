#!/usr/bin/env bash

# Shared helpers for hooks which operate on every Go module in a repository.

list_go_module_files() {
  if command -v fd >/dev/null 2>&1; then
    fd \
      --hidden \
      --no-ignore \
      --type f \
      --glob go.mod \
      --exclude .git \
      --exclude vendor \
      --print0 \
      .
  else
    find . \
      \( -type d \( -name .git -o -name vendor \) -prune \) -o \
      \( -type f -name go.mod -print0 \)
  fi
}

find_go_modules() {
  local mod_file
  GO_MODULE_DIRS=()

  while IFS= read -r -d '' mod_file; do
    GO_MODULE_DIRS+=("$(dirname "$mod_file")")
  done < <(list_go_module_files)

  if ((${#GO_MODULE_DIRS[@]} == 0)); then
    printf 'No Go modules found.\n'
    return 1
  fi
}

run_in_go_modules() {
  local description=$1
  shift

  find_go_modules || return 0

  local module_dir
  for module_dir in "${GO_MODULE_DIRS[@]}"; do
    printf '%s in %s\n' "$description" "$module_dir"
    (cd "$module_dir" && "$@") || return $?
  done
}
