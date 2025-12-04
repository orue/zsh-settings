#!/usr/bin/env zsh

# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# ============================================================================
# PATH Configuration
# ============================================================================
# Use typeset -U to automatically prevent PATH duplicates.
# This makes the `path` array the source of truth for the $PATH variable.
typeset -U path

# ============================================================================
# PROFILING (Uncomment to measure startup time)
# ============================================================================
# zmodload zsh/zprof

# Cache brew shellenv output
if command -v brew &>/dev/null; then
  if [[ ! -f "$ZDOTDIR/.brew_env.zsh" ]] || [[ $(command -v brew) -nt "$ZDOTDIR/.brew_env.zsh" ]]; then
    brew shellenv > "$ZDOTDIR/.brew_env.zsh"
  fi
  builtin source "$ZDOTDIR/.brew_env.zsh"
fi

# ============================================================================
# ZSH OPTIONS
# ============================================================================
# History Configuration
HISTSIZE=50000        # Increased to match SAVEHIST
SAVEHIST=50000
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..|history|env|export *)"
HISTFILE=$ZDOTDIR/.zsh_history

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# General Options
setopt CORRECT              # Command correction only
setopt AUTO_CD              # Auto change directory
setopt EXTENDED_GLOB        # Extended globbing
setopt PUSHD_SILENT         # Don't print directory stack
setopt NO_BEEP              # No beeping
setopt PROMPT_SUBST         # Allow prompt substitution

# ============================================================================
# ZLE & PROMPT CONFIGURATION
# ============================================================================
# ZLE Highlighting
zle_highlight=(
  paste:none
  isearch:underline
  region:standout
  special:standout
  suffix:bold
)

# Git performance optimization (for prompts)
DISABLE_UNTRACKED_FILES_DIRTY=true

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================
# Docker completions (lazy-load to reduce startup)
[[ -d /Users/orue/.docker/completions ]] && fpath=(/Users/orue/.docker/completions $fpath)

# Optimized completion initialization
autoload -Uz compinit
# Strategy: Only rebuild dump if older than 20 hours
# This balances performance with keeping completions fresh
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+20) ]]; then
  compinit
else
  compinit -C
fi

# Completion styling and performance options
zstyle ':completion:*' menu select
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zmodload zsh/complist
_comp_options+=(globdots)  # Include hidden files in completion

# ============================================================================
# COLORS
# ============================================================================
# SSH with 256 colors
alias ssh='TERM="xterm-256color" ssh'

# ============================================================================
# LOAD FUNCTIONS & CONFIGURATIONS
# ============================================================================
# Source functions first to make zsh_add_file and zsh_add_plugin available
# Note: Must use 'builtin source' here since zsh_add_file is defined in this file
if [[ -f "$ZDOTDIR/functions.zsh" ]]; then
    builtin source "$ZDOTDIR/functions.zsh"
fi

# Load configuration files (using zsh_add_file from functions.zsh)
zsh_add_file "colors.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "user-aliases.zsh"
zsh_add_file "go.zsh"
zsh_add_file "nvm.zsh"
zsh_add_file "python-venv.zsh"
zsh_add_file "transient-prompt.zsh"

# ============================================================================
# DIRECTORY CHANGE HOOKS
# ============================================================================
# Consolidated chpwd hook for better performance
autoload -U add-zsh-hook
_chpwd_hook() {
  # Auto-switch Node versions
  if [[ $(type -w check_nvm) == *function* ]]; then
    check_nvm || true
  fi

  # Auto-activate Python virtual environments
  if [[ $(type -w python_venv) == *function* ]]; then
    python_venv || true
  fi
}
add-zsh-hook chpwd _chpwd_hook

# Initialize environment checkers
[[ $(type -w check_nvm) == *function* ]] && check_nvm || true
[[ $(type -w python_venv) == *function* ]] && python_venv || true

# ============================================================================
# PLUGINS (zsh-syntax-highlighting MUST be last)
# ============================================================================
# Plugin loading strategy:
# - Critical plugins (autosuggestions, autopair) load immediately
# - Syntax highlighting loads last (required for UX)
# - Optional: Uncomment ENABLE_ASYNC_PLUGINS=true below for zsh-defer based async loading
#   (requires: git clone https://github.com/romkatv/zsh-defer ~/.config/zsh/plugins/zsh-defer)

if [[ "${ENABLE_ASYNC_PLUGINS:-false}" == "true" ]]; then
  # Async plugin loading strategy (optional - disabled by default)
  zsh_add_plugin "romkatv/zsh-defer"
  zsh_add_plugin "zsh-users/zsh-autosuggestions"
  zsh_add_plugin "zsh-users/zsh-history-substring-search"
  zsh defer zsh_add_plugin "hlissner/zsh-autopair"
  zsh defer zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
else
  # Standard synchronous loading (recommended for most users)
  zsh_add_plugin "zsh-users/zsh-autosuggestions"
  zsh_add_plugin "zsh-users/zsh-history-substring-search"
  zsh_add_plugin "hlissner/zsh-autopair"
  zsh_add_plugin "zsh-users/zsh-syntax-highlighting"  # MUST be last for performance
fi

# ============================================================================
# PROMPT INITIALIZATION
# ============================================================================
# Initialize Starship prompt (after all config and plugins are loaded)
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  # Fallback to basic prompt if starship is not installed
  PROMPT='%F{blue}%~%f %# '
fi

# ============================================================================
# KEY BINDINGS (after plugins)
# ============================================================================
# History substring search (requires plugin loaded above)
bindkey '^[[A' history-substring-search-up      # Up arrow
bindkey '^[[B' history-substring-search-down    # Down arrow
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# ============================================================================
# FZF INTEGRATION
# ============================================================================
cache_command "fzf" "$ZDOTDIR/.fzf_env.zsh" fzf --zsh

# ============================================================================
# TOOL COMPLETIONS (cached for faster startup)
# ============================================================================
cache_command "uv" "$ZDOTDIR/.uv_completion.zsh" uv generate-shell-completion zsh
cache_command "uvx" "$ZDOTDIR/.uvx_completion.zsh" uvx --generate-shell-completion zsh

# ============================================================================
# LAZY LOADING - CONDA
# ============================================================================
function init_conda() {
  # Try to find conda in common installation locations
  local conda_locations=(
    "/opt/anaconda3"
    "/opt/miniconda3"
    "$HOME/anaconda3"
    "$HOME/miniconda3"
    "/usr/local/anaconda3"
    "/usr/local/miniconda3"
  )

  local conda_base=""
  for location in "${conda_locations[@]}"; do
    if [[ -f "$location/bin/conda" ]]; then
      conda_base="$location"
      break
    fi
  done

  if [[ -z "$conda_base" ]]; then
    echo "conda installation not found"
    return 1
  fi

  __conda_setup="$('$conda_base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
  else
    if [[ -f "$conda_base/etc/profile.d/conda.sh" ]]; then
      . "$conda_base/etc/profile.d/conda.sh"
    else
      export PATH="$conda_base/bin:$PATH"
    fi
  fi
  unset __conda_setup
  conda config --set auto_activate_base false 2>/dev/null
}

# Auto-initialize conda when first called
function conda() {
  unfunction conda
  init_conda
  conda "$@"
}

# ============================================================================
# POST-HOOKS
# ============================================================================
# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

# ============================================================================
# PROFILING (Uncomment to see results)
# ============================================================================
# zprof
