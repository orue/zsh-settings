#!/usr/bin/env zsh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Generate Password
alias pw='openssl rand -base64 16 | colrm 17'

# Terminal
alias c='clear'
alias h='history'
alias v='vim'
alias e='exit'
alias r='source ~/.config/zsh/.zshrc'

# NPM
alias npmgl="npm ls -g --depth 0"
alias nkiller='rm -rf node_modules/ && npm install'

# Yarn
alias ykiller='rm -rf node_modules/ && yarn install'

# git aliases
alias github="gh repo view --web"

# Open files with VSCode and nvim
alias -s {md,json}='code -n --profile "Default"'
alias -s {html,css,js,ts}='code -n --profile "JS"'
alias -s py='code -n --profile "Python"'
alias -s txt=nvim
alias -s sh=nvim

#  Search terminal history
alias hs='history | grep -i'
alias clear_history='echo "" > ~/.zsh_history & exec $SHELL -l'

# Editor lauchers
alias vim='/opt/homebrew/bin/nvim'
alias pych="open -b com.jetbrains.pycharm ."
alias vco="code ."
alias vc="code"

# Remote Servers
alias ssh='TERM="xterm-256color" ssh'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'

# Generate a uuid-v4
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'

# Show IP
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# eza
alias ls='eza --icons -F -H --group-directories-first --git -1'
alias l="eza -ghlH --git --icons"
alias ll="eza -aghlH --group-directories-first --git --git-repos --icons --sort=type"
function tree() {
  eza -agTF --tree --icons --group-directories-first --git-ignore --git --git-repos --level="${1:-1}"
}

# File operations
alias cp='cp -iv'       # Preferred 'cp' implementation
alias mv='mv -iv'       # Preferred 'mv' implementation
alias mkdir='mkdir -pv' # Preferred 'mkdir' implementation
alias rm='rm -i'
alias rmrf='rm -rf'
alias f='open -a Finder ./' # f:            Opens current directory in MacOS Finder

# easier to read disk
alias df='df -h' # human-readable sizes

#Homebrew Update
alias brewup='brew update; brew upgrade; brew upgrade --cask; brew autoremove; brew cleanup; brew doctor'
