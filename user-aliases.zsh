#!/usr/bin/env zsh

# ============================================================================
# PERSONAL ALIASES & FUNCTIONS
# ============================================================================

# ============================================================================
# NAVIGATION FUNCTIONS
# ============================================================================
# Note: PATH variables (OBSIDIAN_PATH, DEV_PATH, GITHUB_PATH) are in exports.zsh

# Generic navigation helper
_nav() {
  cd "$1" || { echo "❌ Cannot access $2"; return 1; }
}

# Navigation shortcuts
notes() { _nav "$OBSIDIAN_PATH" "Obsidian notes"; }
docs()  { _nav "$HOME/Documents" "Documents"; }
dl()    { _nav "$HOME/Downloads" "Downloads"; }
desk()  { _nav "$HOME/Desktop" "Desktop"; }
dev()   { _nav "$DEV_PATH" "dev folder"; }
github() { _nav "$GITHUB_PATH" "GitHub folder"; }
conf()  { _nav "$HOME/.config" ".config"; }

# ============================================================================
# DATABASE
# ============================================================================
# Use brew --prefix for cross-platform compatibility (Intel vs Apple Silicon)
if command -v brew &>/dev/null; then
  local sqlite_path
  sqlite_path=$(brew --prefix sqlite 2>/dev/null)
  if [[ -n "$sqlite_path" ]] && [[ -x "$sqlite_path/bin/sqlite3" ]]; then
    alias sqlite-dev="$sqlite_path/bin/sqlite3"
  fi
fi

# ============================================================================
# SSH CONNECTIONS
# ============================================================================
# Server connections (add host details in ~/.ssh/config)
alias azul="ssh azul"      # SSH to azul server
alias ziggy="ssh ziggy"    # SSH to ziggy server

