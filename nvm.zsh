#!/usr/bin/env zsh

# Initialize ZSH_NVM_VERSION  to ensure it starts in a known state
export ZSH_NVM_VERSION=""

# Enable debug mode if NVM_DEBUG_MODE is set
NVM_DEBUG_MODE=${NVM_DEBUG_MODE:-0}

# Debug logging function
nvm_debug_log() {
  if [[ $NVM_DEBUG_MODE -eq 1 ]]; then
    echo "DEBUG: $@"
  fi
}

check_nvm() {
  local dir=$(pwd)
  local found_nvm=0
  local nvm_file_path=""
  local nvm_file_names=(".node-version" ".nvmrc")

  nvm_debug_log "check_nvm $dir"

  while [[ $dir != "/" ]]; do
    for nvm_file_name in "${nvm_file_names[@]}"; do
      nvm_debug_log "checking $dir/$nvm_file_name"
      if [[ -f "$dir/$nvm_file_name" ]]; then
        nvm_debug_log "found $dir/$nvm_file_name"
        found_nvm=1
        nvm_file_path="$dir/$nvm_file_name"
        break 2 # Break out of both loops
      fi
    done
    dir=$(dirname "$dir")
  done

  if [[ $found_nvm -eq 1 ]]; then
    nvm_debug_log "found_nvm -eq $found_nvm at $nvm_file_path"
    if [[ -z "$ZSH_NVM_VERSION" ]]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvm_file_path}")")
      printf "Activating  ${node_color}%'s\n" $nvmrc_node_version
      export ZSH_NVM_VERSION="$nvm_file_path"
      nvm use --silent
      nvm_debug_log "ZSH_NVM_VERSION=$ZSH_NVM_VERSION"
    fi
  else
    if [[ -n "$ZSH_NVM_VERSION" ]]; then
      nvm use default --silent
      unset ZSH_NVM_VERSION
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd check_nvm

# Run check_nvm initially to set the correct state
check_nvm
