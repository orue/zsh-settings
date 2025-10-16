#!/usr/bin/env zsh

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================
alias zsh-update-plugins='find "$ZDOTDIR/plugins" -type d -exec test -e "{}/.git" ";" -print0 | xargs -I {} -0 git -C {} pull -q'
alias zshrc='nvim $ZDOTDIR/.zshrc'
alias zshconf='cd $ZDOTDIR && nvim .'

# ============================================================================
# TERMINAL & SYSTEM
# ============================================================================
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias r='reload'                                          # Use function from functions.zsh
alias hc='read "?Clear history? (y/N): " && [[ $REPLY =~ ^[Yy]$ ]] && echo "" > $HISTFILE && reload'
alias edit-hosts='sudo nvim /etc/hosts'

# System Info
alias df='df -h'                                          # Human-readable disk usage
alias du='du -h'                                          # Human-readable directory sizes
alias mem='top -l 1 -s 0 | grep PhysMem'                 # Memory usage
alias cpu='top -l 1 -s 0 | grep "CPU usage"'             # CPU usage

# ============================================================================
# EDITOR
# ============================================================================
alias vim='nvim'
alias vi='nvim'
alias -s {txt,md,json,yaml,yml}='nvim'                   # Open these file types with nvim

# ============================================================================
# FILE OPERATIONS
# ============================================================================
alias cp='cp -iv'                                         # Interactive, verbose
alias mv='mv -iv'                                         # Interactive, verbose
alias rm='rm -i'                                          # Interactive
alias rmrf='rm -rfI'                                      # Interactive for 3+ files
alias mkdir='mkdir -pv'                                   # Create parent dirs, verbose

# Makes new directory and jumps inside
mcd() { mkdir -pv "$1" && cd "$1"; }

# ============================================================================
# EZA (Modern ls replacement)
# ============================================================================
alias ls='eza --icons=always -F -H --group-directories-first --git -1'
alias l='eza --icons --color-scale size --no-user --no-permissions --group-directories-first --git -l'
alias ll='eza -aghlH --group-directories-first --git --git-repos --icons=always --sort=type --ignore-glob=.DS_Store'
alias la='eza -a --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons --group-directories-first'

# Tree with custom depth (default: 1)
tree() {
  local level="${1:-1}"
  eza -agTF --tree --icons --group-directories-first --git-ignore --git --git-repos --level="$level"
}

# ============================================================================
# GIT ALIASES
# ============================================================================
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gl='git log --oneline --graph --decorate --all -20'
alias gll='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(cyan)%ar%Creset %s %C(green)%an%Creset" --abbrev-commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git reset'
alias grh='git reset --hard'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gclean='git clean -fd'
alias gwip='git add . && git commit -m "WIP"'            # Quick work-in-progress commit

# GitHub CLI
alias ghweb='gh repo view --web'
alias ghpr='gh pr view --web'
alias ghissue='gh issue view --web'

# ============================================================================
# SEARCH & FIND
# ============================================================================
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ============================================================================
# NETWORK & CONNECTIVITY
# ============================================================================
alias ping='ping -c 5'
alias localip='ipconfig getifaddr en0'
alias publicip='curl -s ifconfig.me'
alias ipinfo='curl -s ipinfo.io | jq'
alias openports='sudo lsof -i -P -n | grep LISTEN'
alias ports='netstat -tuln'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

# ============================================================================
# UTILITIES
# ============================================================================
alias gpass='openssl rand -base64 32 | tr -dc "A-Za-z0-9!@#$%^&*()" | head -c 20; echo'
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'

# ============================================================================
# HOMEBREW
# ============================================================================
# Full system update
update() {
  echo "🍺 Updating Homebrew..."
  brew update || { echo "❌ brew update failed"; return 1; }

  echo "\n📦 Upgrading formulae..."
  brew upgrade || { echo "❌ brew upgrade failed"; return 1; }

  echo "\n🎯 Upgrading casks..."
  brew upgrade --cask || { echo "❌ brew upgrade --cask failed"; return 1; }

  echo "\n🧹 Cleaning up..."
  brew autoremove
  brew cleanup

  echo "\n🩺 Running diagnostics..."
  brew doctor

  echo "\n✅ Update complete!"
}

# Quick brew commands
alias bi='brew install'
alias bci='brew install --cask'
alias bup='brew update'
alias binfo='brew info'
alias blist='brew list'
alias bsearch='brew search'

