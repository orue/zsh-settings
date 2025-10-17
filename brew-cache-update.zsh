#!/usr/bin/env zsh
# ============================================================================
# Brew Shellenv Cache Updater
# ============================================================================
# This script manually regenerates the brew shellenv cache.
# Run this after updating Homebrew or if you encounter brew-related issues.
#
# Usage: source ~/.config/zsh/brew-cache-update.zsh
# ============================================================================

if [[ -f /opt/homebrew/bin/brew ]]; then
    echo "Updating brew shellenv cache..."
    /opt/homebrew/bin/brew shellenv > "$ZDOTDIR/.brew_env.zsh"
    echo "✓ Cache updated at $ZDOTDIR/.brew_env.zsh"
    echo "Reload your shell to apply changes: exec zsh"
else
    echo "Error: Homebrew not found at /opt/homebrew/bin/brew"
    return 1
fi
