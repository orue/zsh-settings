#!/usr/bin/env zsh

#  Folder Navigation
alias notes='cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Notes && ls'
alias docs='cd $HOME/Documents/ && ls'
alias dl='cd $HOME/Downloads/'
alias desk='cd $HOME/Desktop/'

# Development folders
alias dev='cd $HOME/dev/ && ls'
alias github='cd $HOME/dev/GitHub/orue/ && ls'

alias conf='cd $HOME/.config/ && l'

# Alias for run last SQLite
alias my-sqlite="echo 'Using for the homebrew installed sqlite3. Set up the alias' && /opt/homebrew/opt/sqlite/bin/sqlite3"

# SSH home servers
alias azul="ssh azul"
alias ziggy="ssh ziggy"

# npm and yarn
alias npmgl="npm ls -g --depth 0"                    # Check global npm packages
alias nkiller='rm -rf node_modules/ && npm install'  # Remove node_modules and install npm packages

