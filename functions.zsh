#!/usr/bin/env zsh
# ==============================================================================
# ZSH Custom Functions
# ==============================================================================
# This file contains utility functions for shell management, plugin handling,
# file operations, and development workflow automation.
#
# Core utilities: debug_log, find_up, cache_command, reload
# File operations: fzf_edit, extract, mkarchive
# ZSH management: zsh_add_file, zsh_add_plugin, zsh_add_completion
# Development: nvim_clean, mcd, tree, update
# ==============================================================================

# Debug logging function (set DEBUG_MODE=1 to enable)
# Usage: debug_log "message"
function debug_log() {
    [[ ${DEBUG_MODE:-0} -eq 1 ]] && echo "DEBUG: $@"
}

# Walk up directory tree to find a file or directory
# Usage: find_up <patterns...>
# Returns: path to first matching file/directory, or empty string if not found
# Example: find_up ".nvmrc" ".node-version"
function find_up() {
    local dir=$(pwd)
    local patterns=("$@")

    while [[ $dir != "/" ]]; do
        for pattern in "${patterns[@]}"; do
            if [[ -e "$dir/$pattern" ]]; then
                echo "$dir/$pattern"
                return 0
            fi
        done
        dir=$(dirname "$dir")
    done
    return 1
}

# Cache command output for faster startup
# Usage: cache_command <command_name> <cache_file> <command> [args...]
# Example: cache_command "fzf" "$ZDOTDIR/.fzf_env.zsh" fzf --zsh
function cache_command() {
    local cmd_name="$1"
    local cache_file="$2"
    shift 2

    if ! command -v "$cmd_name" &>/dev/null; then
        return 1
    fi

    # Regenerate cache if it doesn't exist or if command is newer than cache
    if [[ ! -f "$cache_file" ]] || [[ $(command -v "$cmd_name") -nt "$cache_file" ]]; then
        "$@" > "$cache_file"
    fi
    builtin source "$cache_file"
}

# Function to reload the shell
function reload() {
    # if reloading, some env vars that are already set can interfere with nvm
    if [ -n "$NVM_BIN" ]; then
        # `nvm deactivate` will cleanup any remaining env vars
        nvm deactivate --silent
    fi
    exec zsh
}

# Fuzzy find and edit files using fzf
# Uses bat for preview if available, falls back to cat
# Supports multiple file selection with -m flag
function fzf_edit() {
    if ! command -v fzf &> /dev/null; then
        echo "${error_color}Error: fzf is not installed${RESET}"
        return 1
    fi

    local preview_cmd="cat {}"
    if command -v bat &> /dev/null; then
        preview_cmd="bat --color=always {}"
    fi

    local files
    files=$(fzf -m --preview="$preview_cmd" --layout=reverse)
    if [[ -n "$files" ]]; then
        ${EDITOR:-nvim} "$files"
    fi
}

# Clean nvim config
function nvim_clean() {
    local config_dir="$HOME/.config/nvim"
    if [[ -d "$config_dir" ]]; then
        echo "${warning_color}Warning: This will delete all nvim configuration!${RESET}"
        echo "Directories to be removed:"
        echo "  - $config_dir"
        echo "  - $HOME/.local/share/nvim"
        echo "  - $HOME/.local/state/nvim"
        echo "  - $HOME/.local/cache/nvim"
        read -q "REPLY?Continue? (y/n) "
        echo
        if [[ "$REPLY" == "y" ]]; then
            echo "Cleaning nvim config..."
            rm -rf "$config_dir"
            rm -rf "$HOME/.local/share/nvim"
            rm -rf "$HOME/.local/state/nvim"
            rm -rf "$HOME/.local/cache/nvim"
            echo "${success_color}nvim config cleaned.${RESET}"
        else
            echo "Cancelled."
        fi
    else
        echo "${error_color}nvim config directory does not exist.${RESET}"
    fi
}

# Source a ZSH configuration file if it exists
# Usage: zsh_add_file "filename.zsh"
# Example: zsh_add_file "aliases.zsh"
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && builtin source "$ZDOTDIR/$1"
}

# Internal helper to locate plugin main file
# Tries .plugin.zsh first, then falls back to .zsh
# Returns: path to plugin file if found, nothing otherwise
function _find_plugin_file() {
    local plugin_file="$1/$2.plugin.zsh"
    [[ -f "$plugin_file" ]] || plugin_file="$1/$2.zsh"
    [[ -f "$plugin_file" ]] && echo "$plugin_file"
}

# Install and load a ZSH plugin from GitHub
# Automatically clones the plugin if not present, then sources it
# Usage: zsh_add_plugin "user/repo"
# Example: zsh_add_plugin "zsh-users/zsh-autosuggestions"
function zsh_add_plugin() {
    local repo="$1"
    local plugin_name="${repo:t}"
    local plugin_dir="$ZDOTDIR/plugins/$plugin_name"

    # Clone plugin if it doesn't exist
    if [[ ! -d "$plugin_dir" ]]; then
        git clone --depth 1 "https://github.com/$repo.git" "$plugin_dir" || {
            echo "${error_color}Error: Failed to clone $repo${RESET}"
            return 1
        }
    fi

    # Find and source the plugin file
    local plugin_file=$(_find_plugin_file "$plugin_dir" "$plugin_name")
    if [[ -n "$plugin_file" ]]; then
        builtin source "$plugin_file"
    else
        echo "${error_color}Error: Plugin file not found for $plugin_name${RESET}"
        return 1
    fi
}

# Install and register ZSH completion scripts from GitHub
# Automatically clones if not present, adds to fpath, and regenerates completion dump
# Usage: zsh_add_completion "user/repo" [true]
# Example: zsh_add_completion "zsh-users/zsh-completions"
# Optional second argument: pass true to initialize completion immediately
function zsh_add_completion() {
    local repo="$1"
    local plugin_name="${repo:t}"
    local plugin_dir="$ZDOTDIR/plugins/$plugin_name"

    if [[ -d "$plugin_dir" ]]; then
        # Plugin directory exists, add completion file to fpath
        local completion_file=("$plugin_dir"/_*)
        if [[ -f "$completion_file[1]" ]]; then
            fpath+=("${completion_file[1]:h}")
            zsh_add_file "plugins/$plugin_name/$plugin_name.plugin.zsh"
        else
            echo "${error_color}Error: Completion file not found for $plugin_name${RESET}"
        fi
    else
        # Clone the plugin repository
        git clone --depth 1 "https://github.com/$repo.git" "$plugin_dir" || {
            echo "${error_color}Error: Failed to clone $repo${RESET}"
            return 1
        }

        # Add completion file to fpath
        local completion_file=("$plugin_dir"/_*)
        if [[ -f "$completion_file[1]" ]]; then
            fpath+=("${completion_file[1]:h}")
        else
            echo "${error_color}Error: Completion file not found for $plugin_name after cloning${RESET}"
        fi

        # Regenerate completion dump if it exists
        [[ -f "$ZDOTDIR/.zcompdump" ]] && rm -f "$ZDOTDIR/.zcompdump"
    fi

    # Initialize completion for the specific command if requested
    if [[ "$2" == true && -f "$completion_file[1]" ]]; then
        local completion_name="${completion_file[1]:t:r}"
        compinit "$completion_name"
    fi
}

# Create archive from given directory
function mkarchive() {
    if [[ -z "$1" ]]; then
        echo "${warning_color}Usage: mkarchive <directory>${RESET}"
        return 1
    fi
    if [[ ! -d "$1" ]]; then
        echo "${error_color}Error: '$1' is not a directory${RESET}"
        return 1
    fi
    tar -czvf "$1.tar.gz" "$1"
}

# Extract archive
function extract() {
    if [[ -z "$1" ]]; then
        echo "${warning_color}Usage: extract <archive_file>${RESET}"
        echo "${info_color}Supported formats: tar.bz2, tar.gz, bz2, rar, gz, tar, tbz2, tgz, zip, Z, 7z${RESET}"
        return 1
    fi
    if [[ -f "$1" ]]; then
        case "$1" in
        *.tar.bz2) tar xvjf "$1" ;;
        *.tar.gz) tar xvzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xvf "$1" ;;
        *.tbz2) tar xvjf "$1" ;;
        *.tgz) tar xvzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "${error_color}Error: '$1' cannot be extracted via extract()${RESET}" ;;
        esac
    else
        echo "${error_color}Error: '$1' is not a valid file${RESET}"
    fi
}

# List aliases
function list_aliases() {
    local filter="$1"
    if [[ -z "$filter" ]]; then
        alias | sort | awk -F'=' -v info="$info_color" -v reset="$RESET" \
            '{printf "%s%-20s%s %s\n", info, $1, reset, $2}'
    else
        alias | grep -i "$filter" | sort | awk -F'=' -v info="$info_color" -v reset="$RESET" \
            '{printf "%s%-20s%s %s\n", info, $1, reset, $2}'
    fi
}

# Makes new directory and jumps inside
function mcd() {
    mkdir -pv "$1" && cd "$1"
}

# Tree with custom depth (default: 1)
function tree() {
    local level="${1:-1}"
    eza -agTF --tree --icons --group-directories-first --git-ignore --git --git-repos --level="$level"
}

# List git repositories with active commits in the last N days
active-repos() {
    local search_dir="${1:-$HOME}"
    local days="${2:-30}"
    local author_email
    author_email=$(git config --global user.email)
    
    echo "Searching for repos with commits in last $days days..."
    echo "Author: $author_email"
    echo ""
    
    find "$search_dir" -name .git -type d -prune 2>/dev/null | while read -r git_dir; do
        (
            repo_dir=$(dirname "$git_dir")
            
            # Change to repo directory in a subshell
            cd "$repo_dir" || exit
            
            # Check for commits by you in the specified time period
            commit_count=$(git log --author="$author_email" --since="$days days ago" --oneline 2>/dev/null | wc -l)
            
            if [ "$commit_count" -gt 0 ]; then
                # Get the last commit date
                last_commit=$(git log --author="$author_email" -1 --format="%ar" 2>/dev/null)
                echo "📁 $repo_dir"
                echo "   └─ $commit_count commit(s), last: $last_commit"
                echo ""
            fi
        )
    done
}

# Full system update
function update() {
    echo "Updating Homebrew..."
    brew update || { echo "Error: brew update failed"; return 1; }
    brew upgrade || { echo "Error: brew upgrade failed"; return 1; }
    brew upgrade --cask || { echo "Error: brew upgrade --cask failed"; return 1; }

    echo "Cleaning up..."
    brew autoremove
    brew cleanup

    echo "Update complete!"
}

# Edit files with sudo while preserving nvim configuration
# Usage: svim <file>
# Example: svim /etc/hosts
# Runs nvim with sudo but maintains access to your personal nvim config
# by preserving the HOME environment variable
function svim() {
    sudo HOME=$HOME nvim "$@"
}

# Get local IP address (more robustly)
# Tries to find the primary active interface
function localip() {
    # Get the default route interface
    local interface=$(route -n get default | grep 'interface' | awk '{print $2}')
    if [[ -n "$interface" ]]; then
        ipconfig getifaddr "$interface"
    else
        # Fallback for Wi-Fi and Ethernet if route fails
        ipconfig getifaddr en0 || ipconfig getifaddr en1
    fi
}

# Quick system stats overview
function sys-stats() {
    echo "--- System Stats ---"
    # CPU Usage
    echo "CPU: $(top -l 1 -s 0 | grep 'CPU usage')"
    # Memory Usage
    echo "MEM: $(top -l 1 -s 0 | grep 'PhysMem')"
    # Disk Usage
    echo "DSK: $(df -h / | awk 'NR==2 {print $4 " free / " $2 " total"}')"
    echo "--------------------"
}

# Fetch gitignore templates from Toptal's gitignore API
# Usage: gi <template> [<template>...]
# Example: gi python,node,macos
# Fetches and outputs gitignore content for specified language/framework templates
function gi() {
    curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$@"
}
