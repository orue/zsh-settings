#!/usr/bin/env zsh

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# don't check for new mail
MAILCHECK=0

#  Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"


# FZF
source <(fzf --zsh)

# ZSH History Configuration
HISTSIZE=10000
SAVEHIST=50000
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
HISTFILE=$ZDOTDIR/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt CORRECT
setopt CORRECT_ALL
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt SHARE_HISTORY
setopt PUSHD_SILENT
setopt NO_BEEP
setopt PROMPT_SUBST

# ZSH Prompt Configuration
zle_highlight=(
  paste:none
  isearch:underline
  region:standout
  special:standout
  suffix:bold
)

DISABLE_UNTRACKED_FILES_DIRTY=true # Disable dirty check for untracked files

# completions with cache optimization
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.

# History search functions
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up   # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Colors
autoload -Uz colors && colors
alias ssh='TERM="xterm-256color" ssh' # Remote Servers SSH connection with 256 colors

# Load functions
source "$ZDOTDIR/functions.zsh"

# Load files
zsh_add_file "variables.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "user-aliases.zsh"
zsh_add_file "nvm.zsh"
zsh_add_file "python-venv.zsh"
zsh_add_file "transient-prompt.zsh"

# ZSH Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "hlissner/zsh-autopair"

# uv and uvx python cli
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Lazy load conda
function init_conda() {
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
      . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="/opt/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  conda config --set auto_activate_base false
}

# Auto-initialize conda when needed
function conda() {
  unfunction conda
  init_conda
  conda "$@"
}


# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
