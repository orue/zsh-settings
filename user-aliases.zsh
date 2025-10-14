#!/usr/bin/env zsh

# Path variables
OBSIDIAN_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

# Folder Navigation
alias notes='cd "$OBSIDIAN_PATH" && ls'
alias docs='cd $HOME/Documents/ && ls'
alias dl='cd $HOME/Downloads/ && ls'
alias desk='cd $HOME/Desktop/ && ls'

# Development folders
alias dev='cd $HOME/dev/ && ls'
alias github='cd $HOME/dev/GitHub/orue/ && ls'
alias conf='cd $HOME/.config/ && l'

# Database
alias my-sqlite="/opt/homebrew/opt/sqlite/bin/sqlite3"

# SSH Connections
alias azul="ssh azul"
alias ziggy="ssh ziggy"

# Check for Node Globals package and Node Folder Cleanup
alias npmgl="npm ls -g --depth 0"
alias nkiller='[[ -d node_modules ]] && rm -rf node_modules/ && npm install || echo "No node_modules found"'

# Display all my repos
alias ghme='cd $HOME/dev/GitHub/orue/ && gh repo list --limit 50'

