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
add_to_path "/opt/homebrew/bin"
add_to_path "/opt/homebrew/opt/libpq/bin"
add_to_path "/opt/homebrew/opt/curl/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.docker/bin"

# ============================================================================
# Application-specific configurations
# ============================================================================

# Go
export GOROOT="/opt/homebrew/opt/go/libexec"
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

# ============================================================================
# External tool loading
# ============================================================================

# Load NVM
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# If reloading, some env vars that are already set can interfere with nvm
if [ -n "$NVM_BIN" ]; then
  # `nvm deactivate` will cleanup any remaining env vars
  nvm deactivate --silent
fi
