#!/usr/bin/env bash

# Shared helpers for hooks which operate on the Go modules selected by
# pre-commit's filtered filename list.

append_go_module_dir() {
  local module_dir=$1
  local existing_dir

  for existing_dir in "${GO_MODULE_DIRS[@]}"; do
    [[ $existing_dir == "$module_dir" ]] && return 0
  done

  GO_MODULE_DIRS+=("$module_dir")
}

find_go_modules_for_files() {
  local file search_dir
  GO_MODULE_DIRS=()

  for file in "$@"; do
    file=${file#./}
    case $file in
      *.go | go.mod | */go.mod | go.sum | */go.sum) ;;
      *) continue ;;
    esac

    search_dir=$(dirname "$file")
    while :; do
      if [[ -f $search_dir/go.mod ]]; then
        [[ $search_dir == "." ]] || search_dir="./$search_dir"
        append_go_module_dir "$search_dir"
        break
      fi
      [[ $search_dir == "." ]] && break
      search_dir=$(dirname "$search_dir")
    done
  done

  if ((${#GO_MODULE_DIRS[@]} == 0)); then
    printf 'No Go modules selected by pre-commit.\n'
    return 1
  fi
}

partition_go_hook_arguments() {
  HOOK_ARGS=()
  HOOK_FILES=()

  local arg
  for arg in "$@"; do
    case $arg in
      *.go | go.mod | */go.mod | go.sum | */go.sum) HOOK_FILES+=("$arg") ;;
      *) HOOK_ARGS+=("$arg") ;;
    esac
  done
}

run_in_selected_go_modules() {
  local description=$1
  shift

  local -a command=("$@")
  find_go_modules_for_files "${HOOK_FILES[@]}" || return 0

  local module_dir
  for module_dir in "${GO_MODULE_DIRS[@]}"; do
    printf '%s in %s\n' "$description" "$module_dir"
    (cd "$module_dir" && "${command[@]}") || return $?
  done
}
