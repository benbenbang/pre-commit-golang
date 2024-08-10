# pre-commit-golang

A modernized version of [dnephin/pre-commit-golang](https://github.com/dnephin/pre-commit-golang), updated to handle nested directory structures and provide better failure handling.

## Features

- Handles nested directory structures like `cmd/xxx/yyy.go`
- Improved failure handling for more robust checks
- Compatible with modern Go project layouts
- Supports multiple Go modules within a repository

## Using these hooks

Add this to your `.pre-commit-config.yaml`:

```yaml
- repo: https://github.com/your-username/pre-commit-golang
  rev: main
  hooks:
    - id: go-fmt
    - id: go-vet
    - id: go-imports
    - id: go-lint # this is actually running staticcheck
    - id: go-cyclo
      args: [-over=15]
    - id: validate-toml
    - id: golangci-lint
    - id: go-critic
    - id: go-unit-tests
    - id: go-build
    - id: go-mod-tidy
    - id: go-mod-vendor
```

## Available hooks
- `go-fmt` - Runs `gofmt`, requires Go
- `go-vet` - Runs `go vet`, requires Go
- `go-imports` - Runs `goimports`, requires golang.org/x/tools/cmd/goimports
- `go-lint` - Run `staticcheck`, requires staticcheck
- `go-cyclo` - Runs `gocyclo`, requires github.com/fzipp/gocyclo
- `validate-toml` - Runs `tomlv`, requires github.com/BurntSushi/toml/tree/master/cmd/tomlv
- `golangci-lint` - Runs `golangci-lint run ./...`, requires golangci-lint
- `go-critic` - Runs `gocritic check ./..`., requires go-critic
- `go-unit-tests` - Runs `go test -tags=unit -timeout 30s -short -v`
- `go-build` - Runs `go build`, requires Go
- `go-mod-tidy` - Runs `go mod tidy -v`, requires Go
- `go-mod-vendor` - Runs `go mod vendor`, requires Go

## Improvements
Nested Directory Support: All hooks now properly handle nested directory structures, including cmd/xxx/yyy.go.
Multi-Module Support: Hooks are designed to work with repositories containing multiple Go modules.
Improved Error Handling: Scripts now provide more informative error messages and handle edge cases more gracefully.
Consistent Output: All hooks provide consistent and clear output, making it easier to identify and resolve issues.

## Requirements
**Go 1.19** or later
Additional tools as listed in the hook descriptions

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments
This project is based on [dnephin/pre-commit-golang](https://github.com/dnephin/pre-commit-golang), originally created by Daniel Nephin. It has been substantially modified and modernized.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
