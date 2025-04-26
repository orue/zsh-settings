#!/usr/bin/env zsh

#  Folder Navigation
alias notes='cd $HOME/Documents/Notes/ && l'
alias docs='cd $HOME/Documents/ && l'
alias github='cd $HOME/GitHub/ && l'
alias dev='cd $HOME/dev/ && l'
alias tuts='cd $HOME/Tutorials/ && l'
alias config='cd $HOME/.config/ && l'
alias dl='cd $HOME/Downloads/'
alias desk='cd $HOME/Desktop/'

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
