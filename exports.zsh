#!/usr/bin/env zsh

# ============================================================================
# Helper functions
# ============================================================================

# Add directory to PATH only if it exists and isn't already in PATH
add_to_path() {
  [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

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

add_to_path "$BREW_PREFIX/bin"
add_to_path "$BREW_PREFIX/opt/libpq/bin"
add_to_path "$BREW_PREFIX/opt/curl/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.docker/bin"

# ============================================================================
# Application-specific configurations
# ============================================================================

# Go
export GOROOT="$BREW_PREFIX/opt/go/libexec"
export GOPATH="$HOME/go"
add_to_path "$GOROOT/bin"
add_to_path "$GOPATH/bin"

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

