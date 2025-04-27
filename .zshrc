#!/usr/bin/env zsh

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

echo "Welcome to $HOST"
echo " "
# don't check for new mail
MAILCHECK=0

#  Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"

# FZF
source <(fzf --zsh)

# ZSH History Configuration
HISTSIZE=25000
SAVEHIST=100000
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

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
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
zsh_add_file "git-aliases.zsh"
zsh_add_file "aws.zsh"
zsh_add_file "nvm.zsh"
zsh_add_file "python-venv.zsh"
zsh_add_file "transient-prompt.zsh"

# ZSH Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "hlissner/zsh-autopair"

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# uv and uvx python cli
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
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
# <<< conda initialize <<<

# Anaconda configuration with pyenv
conda config --set auto_activate_base false

# set AWS Default Region to us-west-2
asr $AWS_DEFAULT_REGION

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
