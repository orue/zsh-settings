#!/usr/bin/env zsh

# ============================================================================
# PERSONAL ALIASES & FUNCTIONS
# ============================================================================

# ============================================================================
# NAVIGATION FUNCTIONS
# ============================================================================
# Note: PATH variables (OBSIDIAN_PATH, DEV_PATH, GITHUB_PATH) are in exports.zsh
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
  cd "$HOME/.config" && ls || { echo "❌ Cannot access .config"; return 1; }
}

# ============================================================================
# DATABASE
# ============================================================================
# Use brew --prefix for cross-platform compatibility (Intel vs Apple Silicon)
alias my-sqlite="$(brew --prefix sqlite 2>/dev/null)/bin/sqlite3"

# ============================================================================
# SSH CONNECTIONS
# ============================================================================
# Server connections (add host details in ~/.ssh/config)
alias azul="ssh azul"      # SSH to azul server
alias ziggy="ssh ziggy"    # SSH to ziggy server

