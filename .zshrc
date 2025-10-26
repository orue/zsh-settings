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
# Check common brew locations and add to PATH if found
if [[ -x /opt/homebrew/bin/brew ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
elif [[ -x /usr/local/bin/brew ]]; then
  export PATH="/usr/local/bin:$PATH"
fi

# Cache brew shellenv output
if command -v brew &>/dev/null; then
  if [[ ! -f "$ZDOTDIR/.brew_env.zsh" ]] || [[ $(command -v brew) -nt "$ZDOTDIR/.brew_env.zsh" ]]; then
    brew shellenv > "$ZDOTDIR/.brew_env.zsh"
  fi
  source "$ZDOTDIR/.brew_env.zsh"
fi

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
# Source functions first to make zsh_add_file and zsh_add_plugin available
# Note: Must use 'source' here since zsh_add_file is defined in this file
if [[ -f "$ZDOTDIR/functions.zsh" ]]; then
    source "$ZDOTDIR/functions.zsh"
fi

# Load configuration files (using zsh_add_file from functions.zsh)
zsh_add_file "colors.zsh"
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
# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# ============================================================================
# PROFILING (Uncomment to see results)
# ============================================================================
# zprof
