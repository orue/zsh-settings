#!/usr/bin/env zsh

#  Folder Navigation
alias dev='cd $HOME/dev/ && l'           # Go to dev folder
alias github='cd $HOME/dev/github/ && l' # Go to github folder

alias box='cd $HOME/Dropbox/ && l'                  # Go to Dropbox folder
alias backup='cd $HOME/Dropbox/backups/ && ll'      # Go to backups folder
alias config='cd $HOME/.config/ && ll'              # Go to config folder
alias nvim-config='cd $HOME/.config/nvim && tree 2' # Go to Neovim config folder
alias zsh-config='cd $HOME/.config/zsh && tree 2'   # Go to zsh config folder

alias docs='cd $HOME/Documents && l' # Go to documents folder
alias dl='cd $HOME/Downloads/'       # Go to downloads folder
alias desk='cd $HOME/Desktop/'       # Go to desktop folder

# Projects - Personal
alias notes='cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/my_notes && ls'
alias repos='cd $HOME/dev/github/orue && l' # Go to repos folder


# Alias for run last SQLite
alias my-sqlite="echo 'This is just an alias that is using for the homebrew installed sqlite3. Set up the alias' && /opt/homebrew/opt/sqlite/bin/sqlite3"

# SSH personal servers
alias azul="ssh orue@azul" # home server

# npm and yarn
alias npmgl="npm ls -g --depth 0"                    # Check global npm packages
alias nkiller='rm -rf node_modules/ && npm install'  # Remove node_modules and install npm packages
alias ykiller='rm -rf node_modules/ && yarn install' # Remove node_modules and install yarn packages

# Python
alias wp="which python && python --version" # Check Python version
