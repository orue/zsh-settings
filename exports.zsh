#!/usr/bin/env zsh

# ============================================================================
# Essential exports
# ============================================================================
export TERM="xterm-256color"
export EDITOR="nvim"
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"

# ============================================================================
# Homebrew configuration
# ============================================================================
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE
export HOMEBREW_NO_ANALYTICS=TRUE

# ============================================================================
# PATH modifications
# ============================================================================
# Use HOMEBREW_PREFIX if available (set by brew shellenv), otherwise try common locations
BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
[[ ! -d "$BREW_PREFIX" ]] && BREW_PREFIX="/usr/local"

# Add directories to PATH (typeset -U ensures no duplicates)
# Only add if directory exists
[[ -d "$BREW_PREFIX/bin" ]] && path=("$BREW_PREFIX/bin" $path)
[[ -d "$BREW_PREFIX/opt/libpq/bin" ]] && path=("$BREW_PREFIX/opt/libpq/bin" $path)
[[ -d "$BREW_PREFIX/opt/curl/bin" ]] && path=("$BREW_PREFIX/opt/curl/bin" $path)
[[ -d "$BREW_PREFIX/sbin" ]] && path=("$BREW_PREFIX/sbin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.docker/bin" ]] && path=("$HOME/.docker/bin" $path)

# ============================================================================
# Application-specific configurations
# ============================================================================

# Go
export GOROOT="$BREW_PREFIX/opt/go/libexec"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOPROXY="https://proxy.golang.org,direct"         # Official Go module proxy
export GOSUMDB="sum.golang.org"                           # Go checksum database
export CGO_ENABLED=1                                       # Enable C bindings (needed for some packages)
[[ -d "$GOROOT/bin" ]] && path=("$GOROOT/bin" $path)
path=("$GOBIN" $path)

# NVM
export NVM_DIR="$HOME/.nvm"

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"

# Eza
export EZA_CONFIG_DIR="$HOME/.config/eza"

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Personal path shortcuts
export OBSIDIAN_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
export DEV_PATH="$HOME/dev"
export GITHUB_PATH="$HOME/dev/GitHub/orue"

