#!/usr/bin/env zsh

autoload -U add-zsh-hook

load-node-version() {
  local nvmrc_path="$(nvm_find_nvmrc)"
  local node_version_path="$(pwd)/.node-version"

  if [ -f "$node_version_path" ]; then
    local node_version=$(cat "$node_version_path")
    nvm use "$node_version"
  elif [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-node-version
load-node-version
