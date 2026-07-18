#!/usr/bin/env bats

setup_file() {
  PROJECT_ROOT=${GITHUB_WORKSPACE:-"$(cd "$BATS_TEST_DIRNAME" && pwd)"}
  export PROJECT_ROOT
}

setup() {
  TEST_DIR=$(mktemp -d)
  cd "$TEST_DIR"
  echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}' > main.go
  go mod init test_module
  go mod tidy
}

teardown() {
  cd - > /dev/null
  rm -rf "$TEST_DIR"
}

run_script() {
  if [ -x "$PROJECT_ROOT/$1" ]; then
    cd "$TEST_DIR" # Ensure we're in the test directory
    # Initialize Go module for each test if needed
    if [ ! -f "go.mod" ]; then
      go mod init test_module
      go mod tidy
    fi
    echo "Running $1 in $(pwd)"
    run bash "$PROJECT_ROOT/$1" "${@:2}"
    echo "Script output:"
    echo "$output"
    echo "Script exit status: $status"
    cd - > /dev/null
  else
    skip "Script $1 not found or not executable"
  fi
}

@test "run-go-build.sh" {
  run_script "run-go-build.sh"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go build succeeded"* ]]
}

@test "run-go-critic.sh" {
  run_script "run-go-critic.sh" main.go
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go critic analysis completed successfully"* ]]
}

@test "run-go-cyclo.sh" {
  run_script "run-go-cyclo.sh" "-over=10" "."
  echo "Output: $output"
  echo "Status: $status"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go cyclomatic complexity analysis completed successfully"* ]]
}

@test "run-go-fmt.sh" {
  mkdir -p "nested package"
  cp main.go "nested package/second.go"
  run_script "run-go-fmt.sh" main.go "nested package/second.go"
  echo "Output: $output"
  echo "Status: $status"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go formatting completed successfully"* ]] || [[ "$output" == *"All files are correctly formatted"* ]] || [[ "$output" == *"No Go files to format"* ]]
}

@test "run-go-generate.sh" {
  echo '//go:generate echo "Generated"' >> main.go
  run_script "run-go-generate.sh" .
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go generate completed successfully"* ]]
}

@test "run-go-imports.sh" {
  mkdir -p "nested package"
  cp main.go "nested package/second.go"
  run_script "run-go-imports.sh" main.go "nested package/second.go"
  echo "Output: $output"
  echo "Status: $status"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go imports completed"* ]]
}

@test "run-go-lint.sh" {
  run_script "run-go-lint.sh" .
  [ "$status" -eq 0 ]
  [[ "$output" == *"completed successfully"* ]]
}

@test "run-go-mod-tidy.sh" {
  run_script "run-go-mod-tidy.sh"
  [ "$status" -eq 0 ]
  [[ "$output" == *"go.mod and go.sum files are tidy"* ]]
}

@test "run-go-mod-vendor.sh" {
  run_script "run-go-mod-vendor.sh"
  echo "Output: $output"
  echo "Status: $status"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Vendor directories are up to date"* ]]
}

@test "run-go-unit-tests.sh" {
  echo 'package main

import "testing"

func TestMain(t *testing.T) {}' > main_test.go
  run_script "run-go-unit-tests.sh" .
  [ "$status" -eq 0 ]
  [[ "$output" == *"All Go unit tests passed successfully"* ]]
}

@test "run-go-vet.sh" {
  run_script "run-go-vet.sh" .
  [ "$status" -eq 0 ]
  [[ "$output" == *"Go vet succeeded for all packages"* ]]
}

@test "run-golangci-lint.sh" {
  run_script "run-golangci-lint.sh" .
  echo "Output: $output"
  echo "Status: $status"
  [ "$status" -eq 0 ]
}
