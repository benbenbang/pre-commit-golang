# pre-commit-golang

A collection of pre-commit hooks for modern Go repositories, including nested
packages, paths containing spaces, and repositories with multiple Go modules.

## Features

- Formats exactly the staged files supplied by pre-commit
- Safely handles nested paths and paths containing spaces
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
    - id: go-lint # runs staticcheck
    - id: go-cyclo
      args: [-over=15]
    - id: validate-toml
    - id: golangci-lint
    - id: go-critic
    - id: go-unit-tests
    - id: go-unit-tests-args
      args: [-race, -count=1]
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
- `golangci-lint` - Runs `golangci-lint run` in every module, requires golangci-lint
- `go-critic` - Runs `gocritic check` on staged Go files, requires go-critic
- `go-unit-tests` - Runs `go test -v ./...` in every module
- `go-unit-tests-args` - Runs `go test <args> ./...` in every module
- `go-build` - Runs `go build`, requires Go
- `go-mod-tidy` - Runs `go mod tidy -v`, requires Go
- `go-mod-vendor` - Runs `go mod vendor`, requires Go

Hooks which naturally operate on files (`go-fmt`, `go-imports`, `go-critic`, and
`go-cyclo`) use the repository-relative filenames passed by pre-commit. Hooks
which operate on packages or modules run once across every module and do not
accept pre-commit's filename arguments. `vendor` and `.git` directories are
excluded when modules are discovered.

Module discovery uses [`fd`](https://github.com/sharkdp/fd) when it is available
and falls back to POSIX `find`; installing `fd` is optional.

## Requirements
**Go 1.24** or later
Additional tools as listed in the hook descriptions

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments
This project is based on [dnephin/pre-commit-golang](https://github.com/dnephin/pre-commit-golang), originally created by Daniel Nephin. It has been substantially modified and modernized.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
