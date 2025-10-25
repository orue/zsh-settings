#!/usr/bin/env zsh

# python venv - auto activate / deactivate logic

# Initialize ZSH_VIRTUAL_ENV to ensure it starts in a known state
export ZSH_VIRTUAL_ENV=""

# Enable debug mode if DEBUG_MODE is set
DEBUG_MODE=${DEBUG_MODE:-0}

# Debug logging function
debug_log() {
  if [[ $DEBUG_MODE -eq 1 ]]; then
    echo "DEBUG: $@"
  fi
}

# Python venv auto activate/deactivate
# Handles multiple virtual environment directory names
# Activates if venv is in current directory or any parent directory
# Deactivates if no venv is found in current directory or any parent directory
python_venv() {
  local dir=$(pwd)
  local venv_path=""  # Will store the path to the found venv, empty if none found
  # Array of possible venv directory names
  local venv_names=("venv" ".venv")

  debug_log "python_venv $dir"

  # Walk up the directory tree to find a venv
  while [[ $dir != "/" ]]; do
    for venv_name in "${venv_names[@]}"; do
      debug_log "checking $dir/$venv_name"
      if [[ -d "$dir/$venv_name" && -f "$dir/$venv_name/bin/activate" ]]; then
        debug_log "found $dir/$venv_name"
        venv_path="$dir/$venv_name"  # Store the path and stop searching
        break 2 # Break out of both loops
      fi
    done
    dir=$(dirname "$dir")
  done

  # If venv_path is set, a venv was found - activate or switch to it
  if [[ -n "$venv_path" ]]; then
    debug_log "found venv at $venv_path"
    # Check if we need to activate or switch venvs
    if [[ "$ZSH_VIRTUAL_ENV" != "$venv_path" ]]; then
      # Deactivate current venv if one is active
      if [[ -n "$ZSH_VIRTUAL_ENV" ]]; then
        printf "${python_color}Switching virtual environment...${RESET}\n"
        deactivate
      fi
      # Activate the new venv
      printf "${python_color}Activating virtual environment (%s)${RESET}\n" "$(basename $(dirname "$venv_path"))"
      export ZSH_VIRTUAL_ENV="$venv_path"
      source "$venv_path/bin/activate"
    fi
  else
    # venv_path is empty - no venv found, deactivate if one was active
    if [[ -n "$ZSH_VIRTUAL_ENV" ]]; then
      printf "${python_color}Deactivating virtual environment${RESET}\n"
      deactivate
      unset ZSH_VIRTUAL_ENV
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

# Run python_venv initially to set the correct state
python_venv
