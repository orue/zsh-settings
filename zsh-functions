#!/usr/bin/env zsh

# Function to source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Function to add a plugin to the Zsh plugins directory

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" ||
            zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
        completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
        fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
    completion_file="$(basename "${completion_file_path}")"
    if [ "$2" = true ]; then
        compinit "${completion_file:1}"
    fi
}

# Gereate a gitignore file
function gi() {
    curl -sLw n https://www.toptal.com/developers/gitignore/api/$@
}

# Create a new directory and enter it
function mkcd() {
    mkdir -p "$1"
    cd "$1"
}

function mvdir() {
    mv $1/*(DN) $2/
}

# Upgrade pip
function pipup() {
    pip install --upgrade pip
    clear
}

function pyenv-versions() {
    pyenv install -l | rg '^\s+[\d\.]+$' | sort -rV | awk -F. '{if (last_major_minor != $1"."$2) {print; last_major_minor=$1"."$2}}' | sort -V
}
