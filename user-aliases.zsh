#!/usr/bin/env zsh

#  Folder Navigation
alias notes='cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Notes && ls'
alias docs='cd $HOME/Documents/ && ls'
alias dl='cd $HOME/Downloads/'
alias desk='cd $HOME/Desktop/'

# Development folders
alias dev='cd $HOME/dev/ && ls'
alias sandbox='cd $HOME/dev/Sandbox/ && ls'
alias tuts='cd $HOME/dev/Tutorials/ && ls'
alias github='cd $HOME/dev/GitHub/orue/ && ls'
alias gitlab='cd $HOME/dev/GitLab/ && ls'

alias conf='cd $HOME/.config/ && l'

# Alias for run last SQLite
alias my-sqlite="echo 'Using for the homebrew installed sqlite3. Set up the alias' && /opt/homebrew/opt/sqlite/bin/sqlite3"

# SSH personal servers
alias azul="ssh orue@azul" # home server

# npm and yarn
alias npmgl="npm ls -g --depth 0"                    # Check global npm packages
alias nkiller='rm -rf node_modules/ && npm install'  # Remove node_modules and install npm packages
alias ykiller='rm -rf node_modules/ && yarn install' # Remove node_modules and install yarn packages

# Python
alias wp="which python && python --version" # Check Python version
