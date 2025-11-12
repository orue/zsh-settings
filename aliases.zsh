#!/usr/bin/env zsh

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================
alias zsh-update-plugins='find "$ZDOTDIR/plugins" -type d -exec test -e "{}/.git" \; -print0 | xargs -I {} -0 git -C {} pull -q'
alias zshrc='nvim $ZDOTDIR/.zshrc'
alias zshconf='cd $ZDOTDIR && nvim .'

# ============================================================================
# TERMINAL & SYSTEM
# ============================================================================
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hc='read "?Clear history? (y/N): " && [[ $REPLY =~ ^[Yy]$ ]] && echo "" > $HISTFILE && reload'
alias edit-hosts='svim /etc/hosts'

# System Info
alias df='df -h'                                          # Human-readable disk usage
alias du='du -h'                                          # Human-readable directory sizes
alias stats='sys-stats'                                   # System stats overview

# ============================================================================
# EDITOR
# ============================================================================
alias vim='nvim'
alias -s {txt,md,json,yaml,yml}='nvim'                   # Open these file types with nvim


# ============================================================================
# FILE OPERATIONS
# ============================================================================
alias cp='cp -iv'                                         # Interactive, verbose
alias mv='mv -iv'                                         # Interactive, verbose
alias rm='rm -i'                                          # Interactive
alias rmrf='rm -rf'                                       # Force recursive remove (use with caution)
alias ln='ln -i'                                          # Interactive symlinks
alias mkdir='mkdir -pv'                                   # Create parent dirs, verbose
alias cdpwd='echo cd $(pwd) | pbcopy'

# ============================================================================
# EZA (Modern ls replacement)
# ============================================================================
alias ls='eza --icons=always -F -H --group-directories-first --git -1'
alias l='eza --icons --color-scale size --no-user --no-permissions --group-directories-first --git -l'
alias ll='eza -aghlH --group-directories-first --git --git-repos --icons=always --sort=type --ignore-glob=.DS_Store'
alias la='eza -a --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons --group-directories-first'

# GitHub CLI
alias ghweb='gh repo view --web'

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
alias publicip='curl -s ifconfig.me'
alias ipinfo='curl -s ipinfo.io | jq'
alias openports='sudo lsof -i -P -n | grep LISTEN'
alias ports='sudo lsof -iTCP -sTCP:LISTEN -n -P'

# ============================================================================
# UTILITIES
# ============================================================================
alias gpass='LC_ALL=C tr -dc "A-Za-z0-9!@#$%^&*()" < /dev/urandom | head -c 20; echo'
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'

# ============================================================================
# macOS SPECIFIC
# ============================================================================
alias ql='qlmanage -p 2>/dev/null'                       # Quick Look preview
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'  # Flush DNS cache
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'  # Show hidden files
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'   # Hide hidden files


