#!/usr/bin/env zsh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Generate Password
alias gpass='openssl rand -base64 32 | tr -dc "A-Za-z0-9!@#$%^&*()" | head -c 20; echo'
# Homebrew Update
alias update='brew update; brew upgrade; brew upgrade --cask; brew autoremove; brew cleanup; brew doctor'

# Terminal
alias cls='clear'
alias ..='cd ..'                     # Go up one directory
alias ...='cd ../..'                 # Go up two directories
alias reload='exec $SHELL -l'        # Reload shell

alias edit-hosts='sudo nvim /etc/hosts' # Edit hosts file

alias hc='read "?Clear history? (y/N): " && [[ $REPLY =~ ^[Yy]$ ]] && echo "" > $HOME/.zsh_history && exec $SHELL -l' # Clear history
alias grep='grep --color=auto'                           # Always highlight matches in grep
alias ping='ping -c 5'                                   # Ping 5 times
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'        # Generate a uuid-v4
alias df='df -h'                                         # Human Readable disk usage
alias fzf='fzf -m --preview="bat --color=always {}" --layout=reverse'

# Editor lauchers
alias vim=nvim           # Launch Neovim
alias -s {txt,md}='nvim' # open a txt file with cotEditor


# eza - ls alternative
alias ls='eza --icons=always -F -H --group-directories-first --git -1'
alias l="eza --icons --color-scale size --no-user --no-permissions --group-directories-first --git -l"
alias ll="eza -aghlH --group-directories-first --git --git-repos --icons=always --sort=type --ignore-glob=".DS_Store""
tree() { 
  local level="${1:-1}"
  eza -agTF --tree --icons --group-directories-first --git-ignore --git --git-repos --level="$level"
}

# File operations
alias cp='cp -iv'                    # Preferred 'cp' implementation
alias mv='mv -iv'                    # Preferred 'mv' implementation
alias rm='rm -i'                     # Preferred 'rm' implementation
alias rmrf='rm -rfI'                 # Preferred 'rm -rf' implementation
mcd() { mkdir -pv "$1" && cd "$1"; } # Makes new Dir and jumps inside

# Network and SSH
alias localip="ipconfig getifaddr en0"             # Get internal IP address
alias openports='sudo lsof -i -P -n | grep LISTEN' # List all open ports
alias ports='netstat -tuln'                        # Show network connections
alias ipinfo='curl ipinfo.io'                      # Get IP address information
alias mem='top -l 1 -s 0 | grep PhysMem'          # Show memory usage

# Internet speed
alias speed="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

# GitHub CLI
alias ghweb="gh repo view --web" # git open repository on browser

