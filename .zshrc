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

# Brew - Cached for faster startup
if [[ -f /opt/homebrew/bin/brew ]]; then
  if [[ ! -f "$ZDOTDIR/.brew_env.zsh" ]] || [[ /opt/homebrew/bin/brew -nt "$ZDOTDIR/.brew_env.zsh" ]]; then
    /opt/homebrew/bin/brew shellenv > "$ZDOTDIR/.brew_env.zsh"
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
# PROMPT CONFIGURATION
# ============================================================================
# ZLE Highlighting
zle_highlight=(
  paste:none
  isearch:underline
  region:standout
  special:standout
  suffix:bold
)

# Git performance optimization
DISABLE_UNTRACKED_FILES_DIRTY=true

# Starship prompt
eval "$(starship init zsh)"

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
autoload -Uz colors && colors

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
# KEY BINDINGS (after plugins)
# ============================================================================
# History substring search (requires plugin loaded above)
bindkey '^[[A' history-substring-search-up      # Up arrow
bindkey '^[[B' history-substring-search-down    # Down arrow
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# ============================================================================
# FZF INTEGRATION
# ============================================================================
source <(fzf --zsh)

# ============================================================================
# TOOL COMPLETIONS (deferred for faster startup)
# ============================================================================
# UV Python CLI completions
if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi

if command -v uvx &>/dev/null; then
  eval "$(uvx --generate-shell-completion zsh)"
fi

# ============================================================================
# LAZY LOADING - CONDA
# ============================================================================
function init_conda() {
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
  else
    if [[ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]]; then
      . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="/opt/anaconda3/bin:$PATH"
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
