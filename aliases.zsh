#!/usr/bin/env zsh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Generate Password
alias gpass='openssl rand -base64 24 | tr -dc "A-Za-z0-9!@#$%^&*()_+" | head -c 20; echo'
#Homebrew Update
alias update='brew update; brew upgrade; brew upgrade --cask; brew autoremove; brew cleanup; brew doctor'

# Terminal
alias c='clear'                                                          # Clear terminal
alias x='exit'                                                           # Close terminal
alias h='history'                                                        # Show history
alias r='source $ZDOTDIR/.zshrc'                                         # Reload zshrc file
alias edit-zsh='code $HOME/.config/zsh --profile "Default" --new-window' # Edit zsh config file
alias edit-git=' git config --global -e'                                 # Edit git config file
alias edit-hosts='sudo vim /etc/hosts'                                   # Edit hosts file
alias edit='nvim'                                                        # Open a file in Neovim
alias hc='echo "" > $HOME/.zsh_history & exec $SHELL -l'                 # Clear history
alias grep='grep --color=auto'                                           # Always highlight matches in grep
alias ping='ping -c 5'                                                   # Ping 5 times
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'                        # Generate a uuid-v4
alias df='df -h'                                                         # Human Readable disk usage

# Editor lauchers
alias vc="code . --new-window "               # Open current directory in VSCode
alias charm="open -b com.jetbrains.pycharm ." # Open current directory in PyCharm
alias vim='/opt/homebrew/bin/nvim'            # Launch Neovim
alias -s txt='cot -n'                         # open a txt file with cotEditor
alias -s md='code -n --profile "Default"'     # Create and open Markdown file on VSCode

# eza - ls alternative
alias ls='eza --icons=always -F -H --group-directories-first --git -1'
alias l="eza -ghlH --git --icons=always --group-directories-first"
alias ll="eza -aghlH --group-directories-first --git --git-repos --icons=always --sort=type"
tree() { eza -agTF --tree --icons --group-directories-first --git-ignore --git --git-repos --level="${1:-1}"; }

# File operations
alias cp='cp -iv'                     # Preferred 'cp' implementation
alias mv='mv -iv'                     # Preferred 'mv' implementation
alias rm='rm -i'                      # Preferred 'rm' implementation
alias rmrf='rm -rfI'                  # Preferred 'rm -rf' implementation
alias f='open -a Finder ./'           # Opens current directory in MacOS Finder
mcd() { mkdir -pv "$1" && cd "$1"; }  # Makes new Dir and jumps inside
trash() { command mv "$@" ~/.Trash; } # Moves a file to the trash

# Network and SSH
alias localip="ipconfig getifaddr en0"             # Get internal IP address
alias openports='sudo lsof -i -P -n | grep LISTEN' # List all open ports
alias ipinfo='curl ipinfo.io'                      # Get IP address information
alias sshv='ssh -v'                                # SSH with verbose output

# GitHub CLI
alias ghweb="gh repo view --web" # git open repository on browser
alias ghpr="gh pr view"          # git open pull request on browser
