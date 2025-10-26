#!/usr/bin/env zsh

# ============================================================================
# PATH Configuration
# ============================================================================
# Use typeset -U to automatically prevent PATH duplicates
typeset -U path

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
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.docker/bin" ]] && path=("$HOME/.docker/bin" $path)

# ============================================================================
# Application-specific configurations
# ============================================================================

# Go
export GOROOT="$BREW_PREFIX/opt/go/libexec"
export GOPATH="$HOME/go"
[[ -d "$GOROOT/bin" ]] && path=("$GOROOT/bin" $path)
[[ -d "$GOPATH/bin" ]] && path=("$GOPATH/bin" $path)

# NVM
export NVM_DIR="$HOME/.nvm"

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Personal path shortcuts
export OBSIDIAN_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
export DEV_PATH="$HOME/dev"
export GITHUB_PATH="$HOME/dev/GitHub/orue"

