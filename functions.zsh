#!/usr/bin/env zsh

# Function to reload the shell
function reload() {
    # if reloading, some env vars that are already set can interfere with nvm
    if [ -n "$NVM_BIN" ]; then
        # `nvm deactivate` will cleanup any remaining env vars
        nvm deactivate --silent
    fi
    exec zsh
}

function fzf_edit() {
    if ! command -v fzf &> /dev/null; then
        echo "${Red}Error: fzf is not installed${RESET}"
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
        echo "${Yellow}Warning: This will delete all nvim configuration!${RESET}"
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
            echo "${Green}nvim config cleaned.${RESET}"
        else
            echo "Cancelled."
        fi
    else
        echo "${Red}nvim config directory does not exist.${RESET}"
    fi
}

# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Helper to find plugin file
function _find_plugin_file() {
    local plugin_dir="$1"
    local plugin_name="$2"
    local plugin_file="$plugin_dir/$plugin_name.plugin.zsh"

    if [[ ! -f "$plugin_file" ]]; then
        plugin_file="$plugin_dir/$plugin_name.zsh"
    fi

    if [[ -f "$plugin_file" ]]; then
        echo "$plugin_file"
        return 0
    else
        return 1
    fi
}

# Function to add a plugin to the Zsh plugins directory

function zsh_add_plugin() {
    local repo="$1"
    local plugin_name="${repo:t}"
    local plugin_dir="$ZDOTDIR/plugins/$plugin_name"

    if [[ -d "$plugin_dir" ]]; then
        # Plugin directory exists, source the plugin file
        local plugin_file=$(_find_plugin_file "$plugin_dir" "$plugin_name")
        if [[ -n "$plugin_file" ]]; then
            source "$plugin_file"
        else
            echo "${Red}Error: Plugin file not found for $plugin_name${RESET}"
        fi
    else
        # Clone the plugin repository
        git clone --depth 1 "https://github.com/$repo.git" "$plugin_dir" || {
            echo "${Red}Error: Failed to clone $repo${RESET}"
            return 1
        }

        # Source the plugin file after cloning
        local plugin_file=$(_find_plugin_file "$plugin_dir" "$plugin_name")
        if [[ -n "$plugin_file" ]]; then
            source "$plugin_file"
        else
            echo "${Red}Error: Plugin file not found for $plugin_name after cloning${RESET}"
        fi
    fi
}

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
            echo "${Red}Error: Completion file not found for $plugin_name${RESET}"
        fi
    else
        # Clone the plugin repository
        git clone --depth 1 "https://github.com/$repo.git" "$plugin_dir" || {
            echo "${Red}Error: Failed to clone $repo${RESET}"
            return 1
        }

        # Add completion file to fpath
        local completion_file=("$plugin_dir"/_*)
        if [[ -f "$completion_file[1]" ]]; then
            fpath+=("${completion_file[1]:h}")
        else
            echo "${Red}Error: Completion file not found for $plugin_name after cloning${RESET}"
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
        echo "${Yellow}Usage: mkarchive <directory>${RESET}"
        return 1
    fi
    if [[ ! -d "$1" ]]; then
        echo "${Red}Error: '$1' is not a directory${RESET}"
        return 1
    fi
    tar -czvf "$1.tar.gz" "$1"
}

# Extract archive
function extract() {
    if [[ -z "$1" ]]; then
        echo "${Yellow}Usage: extract <archive_file>${RESET}"
        echo "${Yellow}Supported formats: tar.bz2, tar.gz, bz2, rar, gz, tar, tbz2, tgz, zip, Z, 7z${RESET}"
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
        *) echo "${Red}Error: '$1' cannot be extracted via extract()${RESET}" ;;
        esac
    else
        echo "${Red}Error: '$1' is not a valid file${RESET}"
    fi
}

# List aliases
function list_aliases() {
    local filter="$1"
    if [[ -z "$filter" ]]; then
        alias | sort | awk -F'=' -v yellow="$Yellow" -v reset="$RESET" \
            '{printf "%s%-20s%s %s\n", yellow, $1, reset, $2}'
    else
        alias | grep -i "$filter" | sort | awk -F'=' -v yellow="$Yellow" -v reset="$RESET" \
            '{printf "%s%-20s%s %s\n", yellow, $1, reset, $2}'
    fi
}


