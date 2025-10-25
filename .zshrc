#!/usr/bin/env zsh

# ============================================================================
# PROFILING (Uncomment to measure startup time)
# ============================================================================
# zmodload zsh/zprof

# ============================================================================
# PRE-HOOKS
# ============================================================================
# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# ============================================================================
# ENVIRONMENT SETUP
# ============================================================================
# Don't check for new mail
MAILCHECK=0

# Brew - Cached for faster startup (supports both Apple Silicon and Intel Macs)
BREW_LOCATION=""
if [[ -f /opt/homebrew/bin/brew ]]; then
  BREW_LOCATION="/opt/homebrew/bin/brew"
elif [[ -f /usr/local/bin/brew ]]; then
  BREW_LOCATION="/usr/local/bin/brew"
fi

if [[ -n "$BREW_LOCATION" ]]; then
  if [[ ! -f "$ZDOTDIR/.brew_env.zsh" ]] || [[ "$BREW_LOCATION" -nt "$ZDOTDIR/.brew_env.zsh" ]]; then
    "$BREW_LOCATION" shellenv > "$ZDOTDIR/.brew_env.zsh"
  fi
  source "$ZDOTDIR/.brew_env.zsh"
fi
unset BREW_LOCATION

# ============================================================================
# ZSH OPTIONS
# ============================================================================
# History Configuration
HISTSIZE=50000        # Increased to match SAVEHIST
SAVEHIST=50000
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
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
# Optimized completion initialization (only run once per day)
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Completion styling
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)  # Include hidden files

# ============================================================================
# COLORS
# ============================================================================
# SSH with 256 colors
alias ssh='TERM="xterm-256color" ssh'

# ============================================================================
# LOAD FUNCTIONS & CONFIGURATIONS
# ============================================================================
# Load custom functions first (needed for zsh_add_file and zsh_add_plugin)
source "$ZDOTDIR/functions.zsh"

# Load configuration files
zsh_add_file "variables.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "user-aliases.zsh"
zsh_add_file "nvm.zsh"
zsh_add_file "python-venv.zsh"
zsh_add_file "transient-prompt.zsh"

# ============================================================================
# PLUGINS (zsh-syntax-highlighting MUST be last)
# ============================================================================
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"  # MUST be last for performance

# ============================================================================
# PROMPT INITIALIZATION
# ============================================================================
# Initialize Starship prompt (after all config and plugins are loaded)
eval "$(starship init zsh)"

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
# Cached for faster startup
if command -v fzf &>/dev/null; then
  if [[ ! -f "$ZDOTDIR/.fzf_env.zsh" ]] || [[ $(command -v fzf) -nt "$ZDOTDIR/.fzf_env.zsh" ]]; then
    fzf --zsh > "$ZDOTDIR/.fzf_env.zsh"
  fi
  source "$ZDOTDIR/.fzf_env.zsh"
fi

# ============================================================================
# TOOL COMPLETIONS (cached for faster startup)
# ============================================================================
# UV Python CLI completions - cached
if command -v uv &>/dev/null; then
  if [[ ! -f "$ZDOTDIR/.uv_completion.zsh" ]] || [[ $(command -v uv) -nt "$ZDOTDIR/.uv_completion.zsh" ]]; then
    uv generate-shell-completion zsh > "$ZDOTDIR/.uv_completion.zsh"
  fi
  source "$ZDOTDIR/.uv_completion.zsh"
fi

if command -v uvx &>/dev/null; then
  if [[ ! -f "$ZDOTDIR/.uvx_completion.zsh" ]] || [[ $(command -v uvx) -nt "$ZDOTDIR/.uvx_completion.zsh" ]]; then
    uvx --generate-shell-completion zsh > "$ZDOTDIR/.uvx_completion.zsh"
  fi
  source "$ZDOTDIR/.uvx_completion.zsh"
fi

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
# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# ============================================================================
# PROFILING (Uncomment to see results)
# ============================================================================
# zprof
