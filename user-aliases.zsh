#!/usr/bin/env zsh

# ============================================================================
# PERSONAL ALIASES & FUNCTIONS
# ============================================================================

# ============================================================================
# PATH VARIABLES
# ============================================================================
export OBSIDIAN_PATH="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
export DEV_PATH="$HOME/dev"
export GITHUB_PATH="$HOME/dev/GitHub/orue"

# ============================================================================
# NAVIGATION FUNCTIONS (Better error handling than aliases)
# ============================================================================
# Notes & Documents
notes() {
  cd "$OBSIDIAN_PATH" && ls || { echo "❌ Cannot access Obsidian notes"; return 1; }
}

docs() {
  cd "$HOME/Documents" && ls || { echo "❌ Cannot access Documents"; return 1; }
}

dl() {
  cd "$HOME/Downloads" && ls || { echo "❌ Cannot access Downloads"; return 1; }
}

desk() {
  cd "$HOME/Desktop" && ls || { echo "❌ Cannot access Desktop"; return 1; }
}

# Development folders
dev() {
  cd "$DEV_PATH" && ls || { echo "❌ Cannot access dev folder"; return 1; }
}

github() {
  cd "$GITHUB_PATH" && ls || { echo "❌ Cannot access GitHub folder"; return 1; }
}

conf() {
  cd "$HOME/.config" && l || { echo "❌ Cannot access .config"; return 1; }
}

# ============================================================================
# DATABASE
# ============================================================================
alias my-sqlite="/opt/homebrew/opt/sqlite/bin/sqlite3"

# ============================================================================
# SSH CONNECTIONS
# ============================================================================
# Server connections (add host details in ~/.ssh/config)
alias azul="ssh azul"      # SSH to azul server
alias ziggy="ssh ziggy"    # SSH to ziggy server

# ============================================================================
# NODE.JS / NPM
# ============================================================================
alias npmgl="npm ls -g --depth 0"                        # List global packages
alias npml="npm list --depth=0"                          # List local packages
alias npmi="npm install"
alias npms="npm start"
alias npmt="npm test"
alias npmb="npm run build"
alias npmd="npm run dev"

# Clean and reinstall node_modules
nkiller() {
  if [[ -d node_modules ]]; then
    echo "🗑️  Removing node_modules..."
    rm -rf node_modules
    echo "📦 Reinstalling dependencies..."
    npm install
  else
    echo "❌ No node_modules directory found"
    return 1
  fi
}

# Clean node_modules and package-lock.json for fresh install
nfresh() {
  if [[ -d node_modules ]] || [[ -f package-lock.json ]]; then
    echo "🗑️  Removing node_modules and package-lock.json..."
    rm -rf node_modules package-lock.json
    echo "📦 Running fresh npm install..."
    npm install
  else
    echo "❌ Nothing to clean"
    return 1
  fi
}

# ============================================================================
# GITHUB CLI - PERSONAL
# ============================================================================
# Display all my repos
ghme() {
  cd "$GITHUB_PATH" && gh repo list --limit 50 || { echo "❌ Cannot access GitHub repos"; return 1; }
}

# Clone repo and cd into it
ghclone() {
  if [[ -z "$1" ]]; then
    echo "Usage: ghclone <repo-url>"
    return 1
  fi
  gh repo clone "$1" && cd "$(basename "$1" .git)"
}

# ============================================================================
# DOCKER (Optional - uncomment if you use Docker)
# ============================================================================
# alias d='docker'
# alias dc='docker-compose'
# alias dps='docker ps'
# alias dpsa='docker ps -a'
# alias di='docker images'
# alias dstop='docker stop $(docker ps -q)'
# alias drm='docker rm $(docker ps -aq)'
# alias drmi='docker rmi $(docker images -q)'
# alias dprune='docker system prune -a --volumes'

# ============================================================================
# PYTHON (Optional - uncomment if you use Python)
# ============================================================================
# alias py='python3'
# alias pip='pip3'
# alias venv='python3 -m venv'
# alias activate='source venv/bin/activate'

