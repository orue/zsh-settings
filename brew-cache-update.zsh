#!/usr/bin/env zsh
# ============================================================================
# Brew Shellenv Cache Updater
# ============================================================================
# This script manually regenerates the brew shellenv cache.
# Run this after updating Homebrew or if you encounter brew-related issues.
#
# Usage: source ~/.config/zsh/brew-cache-update.zsh
# ============================================================================

BREW_LOCATION=""
if [[ -f /opt/homebrew/bin/brew ]]; then
    BREW_LOCATION="/opt/homebrew/bin/brew"
elif [[ -f /usr/local/bin/brew ]]; then
    BREW_LOCATION="/usr/local/bin/brew"
fi

if [[ -n "$BREW_LOCATION" ]]; then
    echo "Updating brew shellenv cache..."
    "$BREW_LOCATION" shellenv > "$ZDOTDIR/.brew_env.zsh"
    echo "✓ Cache updated at $ZDOTDIR/.brew_env.zsh"
    echo "Reload your shell to apply changes: exec zsh"
    unset BREW_LOCATION
else
    echo "Error: Homebrew not found"
    echo "Expected locations:"
    echo "  - /opt/homebrew/bin/brew (Apple Silicon)"
    echo "  - /usr/local/bin/brew (Intel)"
    return 1
fi
