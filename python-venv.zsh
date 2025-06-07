#!/usr/bin/env zsh

# python venv - auto activate / deactivate logic

# Initialize ZSH_VIRTUAL_ENV  to ensure it starts in a known state
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
  local found_venv=0
  local venv_path=""
  # Array of possible venv directory names
  local venv_names=("venv" ".venv")

  debug_log "python_venv $dir"

  while [[ $dir != "/" ]]; do
    for venv_name in "${venv_names[@]}"; do
      debug_log "checking $dir/$venv_name"
      if [[ -d "$dir/$venv_name" && -f "$dir/$venv_name/bin/activate" ]]; then
        debug_log "found $dir/$venv_name"
        found_venv=1
        venv_path="$dir/$venv_name"
        break 2 # Break out of both loops
      fi
    done
    dir=$(dirname "$dir")
  done

  if [[ $found_venv -eq 1 ]]; then
    debug_log "found_venv -eq $found_venv at $venv_path"
    if [[ -z "$ZSH_VIRTUAL_ENV" ]]; then
      printf "Activating  virtual environment ${python_color}(%'s)\n" $(basename $(pwd))
      export ZSH_VIRTUAL_ENV="$venv_path"
      source "$venv_path/bin/activate"
    fi
  else
    if [[ -n "$ZSH_VIRTUAL_ENV" ]]; then
      # echo "Deactivating virtual environment"
      printf "\nDeactivating  virtual environment\n"
      deactivate
      unset ZSH_VIRTUAL_ENV
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

# Run python_venv initially to set the correct state
python_venv
