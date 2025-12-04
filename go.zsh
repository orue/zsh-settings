#!/usr/bin/env zsh

# ============================================================================
# Go Development Environment
# ============================================================================

# Go Aliases - Common Development Commands
alias gob='go build'                              # Build binary
alias goc='go clean'                              # Clean build cache
alias god='go doc'                                # View documentation
alias gof='go fmt ./...'                          # Format all files
alias gog='go get -u ./...'                       # Update dependencies
alias goi='go install ./cmd/...'                  # Install binaries from cmd/
alias got='go test ./...'                         # Run all tests
alias gotv='go test -v ./...'                     # Run tests with verbose output
alias gotc='go test -cover ./...'                 # Run tests with coverage
alias gomod='go mod tidy && go mod verify'        # Tidy and verify modules
alias gogen='go generate ./...'                   # Run code generation
alias goenv='go env'                              # Show Go environment
alias govet='go vet ./...'                        # Run go vet on all packages

# Go Development with linter (requires golangci-lint)
alias gol='golangci-lint run ./...'               # Run linter
alias golx='golangci-lint run --fix ./...'        # Run linter with fixes

# ============================================================================
# Go Development Functions
# ============================================================================

# Create new Go module project with basic structure
go-new() {
  if [[ -z "$1" ]]; then
    echo "Usage: go-new <module-name>"
    return 1
  fi

  local module_name="$1"

  echo "Creating Go module project: $module_name"
  mkdir -p "$module_name/cmd/app"
  cd "$module_name"

  # Initialize Go module
  go mod init "$module_name"

  # Create main.go
  cat > cmd/app/main.go << 'EOF'
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, World!")
}
EOF

  # Create .gitignore
  cat > .gitignore << 'EOF'
# Binaries
*.exe
*.exe~
*.dll
*.so
*.so.*
*.dylib

# Test binaries
*.test

# Directories
bin/
dist/
vendor/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store
EOF

  # Create README
  cat > README.md << EOF
# $module_name

A Go project.

## Build

\`\`\`bash
go build -o bin/app ./cmd/app
\`\`\`

## Run

\`\`\`bash
go run ./cmd/app
\`\`\`

## Test

\`\`\`bash
go test ./...
\`\`\`
EOF

  echo "✓ Project created: $module_name"
  echo "✓ Module initialized"
  echo "✓ Basic structure created"
  echo ""
  echo "Next steps:"
  echo "  go build -o bin/app ./cmd/app    # Build"
  echo "  go run ./cmd/app                 # Run"
  echo "  go test ./...                    # Test"
}

# Format and lint a Go project
go-fmt() {
  echo "Formatting Go code..."
  go fmt ./...

  if command -v goimports &>/dev/null; then
    echo "Organizing imports..."
    goimports -w .
  fi

  if command -v golangci-lint &>/dev/null; then
    echo "Running linter..."
    golangci-lint run ./...
  else
    echo "Running go vet..."
    go vet ./...
  fi

  echo "✓ Code formatting complete"
}

# Run tests with coverage report
go-coverage() {
  local coverage_file="coverage.out"
  local html_file="coverage.html"

  echo "Running tests with coverage..."
  go test -coverprofile="$coverage_file" ./...

  if [[ $? -eq 0 ]]; then
    go tool cover -html="$coverage_file" -o "$html_file"
    echo "✓ Coverage report generated: $html_file"
    open "$html_file" 2>/dev/null || echo "  (Open $html_file in your browser)"
  fi
}

# Build and install all binaries in cmd/ directory
go-install-all() {
  if [[ ! -f "go.mod" ]]; then
    echo "Error: go.mod not found. Run this in a Go module directory."
    return 1
  fi

  echo "Building and installing binaries from ./cmd/*..."

  local cmd_count=0
  for cmd_dir in cmd/*/; do
    if [[ -d "$cmd_dir" ]]; then
      local cmd_name=$(basename "$cmd_dir")
      echo "  → Installing $cmd_name..."
      go install "./cmd/$cmd_name" || return 1
      ((cmd_count++))
    fi
  done

  echo "✓ Installed $cmd_count command(s)"
}

# View module dependency graph
go-deps() {
  if ! command -v dot &>/dev/null; then
    echo "Error: graphviz not installed. Install with: brew install graphviz"
    return 1
  fi

  local output_file="deps.svg"
  echo "Generating dependency graph..."
  go mod graph | awk '{print "\""$1"\" -> \""$2"\""}' | sort -u > /tmp/go_deps.txt

  {
    echo "digraph {"
    echo "  rankdir=LR;"
    echo "  node [shape=box];"
    cat /tmp/go_deps.txt
    echo "}"
  } | dot -Tsvg -o "$output_file"

  echo "✓ Dependency graph saved to: $output_file"
  open "$output_file" 2>/dev/null || echo "  (Open $output_file in your browser)"
}

# Check for security vulnerabilities in dependencies
go-vulncheck() {
  if ! command -v govulncheck &>/dev/null; then
    echo "Installing govulncheck..."
    go install golang.org/x/vuln/cmd/govulncheck@latest
  fi

  echo "Checking for security vulnerabilities..."
  govulncheck ./...
}

# Benchmark packages
go-bench() {
  if [[ -z "$1" ]]; then
    echo "Running benchmarks for all packages..."
    go test -bench=. -benchmem ./...
  else
    echo "Running benchmarks for package: $1"
    go test -bench=. -benchmem "./$1"
  fi
}

# Display detailed Go environment information
go-info() {
  echo "Go Environment Information"
  echo "=========================="
  echo ""
  go env
  echo ""
  echo "Go version:"
  go version
  echo ""
  echo "Active workspace:"
  pwd
}

# ============================================================================
# Diagnostic and Maintenance Functions
# ============================================================================

# Comprehensive environment diagnostic report
go-diagnose() {
  echo "Go Environment Diagnostic Report"
  echo "=================================="
  echo ""
  echo "System Info:"
  echo "  OS: $(uname -s)"
  echo "  Arch: $(uname -m)"
  echo ""

  echo "Go Installation:"
  go version
  echo "  GOROOT: $(go env GOROOT)"
  echo "  GOPATH: $(go env GOPATH)"
  echo "  GOBIN: $(go env GOBIN)"
  echo "  GOOS: $(go env GOOS)"
  echo "  GOARCH: $(go env GOARCH)"
  echo "  GOARM64: $(go env GOARM64)"
  echo ""

  echo "Module Configuration:"
  echo "  GOPROXY: $(go env GOPROXY)"
  echo "  GOSUMDB: $(go env GOSUMDB)"
  echo "  GOTELEMETRY: $(go env GOTELEMETRY)"
  echo "  CGO_ENABLED: $(go env CGO_ENABLED)"
  echo ""

  echo "Essential Tools:"
  command -v golangci-lint &>/dev/null && echo "  ✓ golangci-lint installed" || echo "  ✗ golangci-lint NOT installed"
  command -v govulncheck &>/dev/null && echo "  ✓ govulncheck installed" || echo "  ✗ govulncheck NOT installed"
  command -v air &>/dev/null && echo "  ✓ air (live reload) installed" || echo "  ✗ air NOT installed"
  command -v goimports &>/dev/null && echo "  ✓ goimports installed" || echo "  ✗ goimports NOT installed"
  echo ""

  echo "Build Cache:"
  local cache_dir=$(go env GOCACHE)
  [[ -d "$cache_dir" ]] && echo "  Cache size: $(du -sh "$cache_dir" 2>/dev/null | cut -f1)" || echo "  Cache not yet created"
}

# Clean Go build artifacts and cache
go-clean-deps() {
  echo "Cleaning Go cache and build artifacts..."
  go clean -cache
  go clean -modcache
  go clean -testcache
  echo "✓ Cache, module cache, and test cache cleaned"
}

