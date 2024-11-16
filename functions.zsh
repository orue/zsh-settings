#!/usr/bin/env zsh

# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Function to add a plugin to the Zsh plugins directory

function zsh_add_plugin() {
    local repo="$1"
    local plugin_name="${repo:t}"
    local plugin_dir="$ZDOTDIR/plugins/$plugin_name"

    if [[ -d "$plugin_dir" ]]; then
        # Plugin directory exists, source the plugin file
        local plugin_file="$plugin_dir/$plugin_name.plugin.zsh"
        if [[ ! -f "$plugin_file" ]]; then
            plugin_file="$plugin_dir/$plugin_name.zsh"
        fi

        if [[ -f "$plugin_file" ]]; then
            source "$plugin_file"
        else
            echo "Error: Plugin file not found for $plugin_name"
        fi
    else
        # Clone the plugin repository
        git clone --depth 1 "https://github.com/$repo.git" "$plugin_dir" || {
            echo "Error: Failed to clone $repo"
            return 1
        }

        # Source the plugin file after cloning
        local plugin_file="$plugin_dir/$plugin_name.plugin.zsh"
        if [[ ! -f "$plugin_file" ]]; then
            plugin_file="$plugin_dir/$plugin_name.zsh"
        fi

        if [[ -f "$plugin_file" ]]; then
            source "$plugin_file"
        else
            echo "Error: Plugin file not found for $plugin_name after cloning"
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
            echo "Error: Completion file not found for $plugin_name"
        fi
    else
        # Clone the plugin repository
        git clone --depth 1 "https://github.com/$repo.git" "$plugin_dir" || {
            echo "Error: Failed to clone $repo"
            return 1
        }

        # Add completion file to fpath
        local completion_file=("$plugin_dir"/_*)
        if [[ -f "$completion_file[1]" ]]; then
            fpath+=("${completion_file[1]:h}")
        else
            echo "Error: Completion file not found for $plugin_name after cloning"
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
    tar -czvf $1.tar.gz $1
}

# Extract archive
function extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# List aliases
function list_aliases() {
    local filter="$1"
    if [[ -z "$filter" ]]; then
        alias | sort | awk -F'=' '{printf "\033[33m%-20s\033[0m %s\n", $1, $2}'
    else
        alias | grep -i "$filter" | sort | awk -F'=' '{printf "\033[33m%-20s\033[0m %s\n", $1, $2}'
    fi
}

# Add a file to the .gitignore
function add_to_gitignore() {
    local gitignore=".gitignore"
    local pattern="$1"

    if [[ ! -f "$gitignore" ]]; then
        echo "$pattern" >"$gitignore"
        echo "Created $gitignore with $pattern"
        return
    fi

    if ! grep -Fxq "$pattern" "$gitignore"; then
        echo "$pattern" >>"$gitignore"
        echo "Added $pattern to $gitignore"
        tail "$gitignore"
    else
        echo "$pattern is already in $gitignore"
    fi
}

# Gereate a gitignore file
function gi() {
    curl -sLw n https://www.toptal.com/developers/gitignore/api/$@
}

# Upgrade pip
function pipup() {
    pip install --upgrade pip
    clear
}
