#!/usr/bin/env zsh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Generate Password
alias pw='openssl rand -base64 24 | tr -dc "A-Za-z0-9!@#$%^&*()_+" | head -c 20; echo'

# Terminal
alias c='clear'
alias v='vim'
alias x='exit'
alias h='history'
alias r='source $ZDOTDIR/.zshrc'
alias edit='nvim'                                        # Open a file in Sublime Text
alias hc='echo "" > $HOME/.zsh_history & exec $SHELL -l' # Clear history

# git open repository on browser
alias ghweb="gh repo view --web"

# Create and open Markdown file on VSCode
alias -s md='code -n --profile "Default"'

# Editor lauchers
alias vim='/opt/homebrew/bin/nvim'
alias pych="open -b com.jetbrains.pycharm ."
alias vco="code ."
alias vc="code"

# Remote Servers SSH connection with 256 colors
alias ssh='TERM="xterm-256color" ssh'

# Ping 5 times
alias ping='ping -c 5'

# Generate a uuid-v4
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'

# Human Readable disk usage
alias df='df -h'

# eza - ls alternative
alias ls='eza --icons=always -F -H --group-directories-first --git -1'
alias l="eza -ghlH --git --icons=always --group-directories-first"
alias ll="eza -aghlH --group-directories-first --git --git-repos --icons=always --sort=type"
tree() { eza -agTF --tree --icons --group-directories-first --git-ignore --git --git-repos --level="${1:-1}"; }

# File operations
alias cp='cp -iv' # Preferred 'cp' implementation
alias mv='mv -iv' # Preferred 'mv' implementation
alias rm='rm -i'
alias rmrf='rm -rf'
alias f='open -a Finder ./'           # Opens current directory in MacOS Finder
mcd() { mkdir -pv "$1" && cd "$1"; }  # Makes new Dir and jumps inside
trash() { command mv "$@" ~/.Trash; } # Moves a file to the trash

#Homebrew Update
alias brewup='brew update; brew upgrade; brew upgrade --cask; brew autoremove; brew cleanup; brew doctor'
