#!/usr/bin/env zsh

# ============================================================================
# LAZY LOADING - NVM
# ============================================================================
# Initialize ZSH_NVM_VERSION to ensure it starts in a known state
export ZSH_NVM_VERSION=""

# Function to initialize NVM (called on first use)
function init_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Lazy-load NVM when first called
function nvm() {
  unfunction nvm
  init_nvm
  nvm "$@"
}

# Generic lazy loader for node commands
function _nvm_lazy_load() {
  unfunction node npm npx
  init_nvm
  nvm use default --silent
}

# Lazy-load for common node commands
function node() {
  _nvm_lazy_load
  node "$@"
}

function npm() {
  _nvm_lazy_load
  npm "$@"
}

function npx() {
  _nvm_lazy_load
  npx "$@"
}

check_nvm() {
  debug_log "check_nvm $(pwd)"

  # Use find_up to locate node version file
  local nvm_file_path=$(find_up ".node-version" ".nvmrc")

  if [[ -n "$nvm_file_path" ]]; then
    debug_log "found nvm file at $nvm_file_path"
    # Check if we need to switch (either no version set, or different .nvmrc file)
    if [[ "$ZSH_NVM_VERSION" != "$nvm_file_path" ]]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvm_file_path}")")
      printf "Activating  ${node_color}%'s\n" $nvmrc_node_version
      export ZSH_NVM_VERSION="$nvm_file_path"
      nvm use --silent
      debug_log "ZSH_NVM_VERSION=$ZSH_NVM_VERSION"
    fi
  else
    if [[ -n "$ZSH_NVM_VERSION" ]]; then
      # Switch back to default (will auto-initialize NVM if needed via wrapper)
      nvm use default --silent
      unset ZSH_NVM_VERSION
    fi
  fi
}
