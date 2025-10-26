#!/usr/bin/env zsh

# python venv - auto activate / deactivate logic

# Initialize ZSH_VIRTUAL_ENV to ensure it starts in a known state
export ZSH_VIRTUAL_ENV=""

# Python venv auto activate/deactivate
# Handles multiple virtual environment directory names
# Activates if venv is in current directory or any parent directory
# Deactivates if no venv is found in current directory or any parent directory
python_venv() {
  debug_log "python_venv $(pwd)"

  # Use find_up to locate venv activation script
  local activate_path=$(find_up "venv/bin/activate" ".venv/bin/activate")
  local venv_path=""

  if [[ -n "$activate_path" ]]; then
    # Extract venv directory path (remove /bin/activate)
    venv_path="${activate_path%/bin/activate}"
    debug_log "found venv at $venv_path"
  fi

  # If venv_path is set, a venv was found - activate or switch to it
  if [[ -n "$venv_path" ]]; then
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
      builtin source "$venv_path/bin/activate"
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
