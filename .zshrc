#!/usr/bin/env zsh

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

echo "Orue.dev"
echo " "
# don't check for new mail
MAILCHECK=0

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#  Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"

# fnm - Node Version Manager
eval "$(fnm env --use-on-cd --shell zsh)"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Zsh settings for history
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
HISTSIZE=25000
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=100000
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

zle_highlight=(
  'paste:none'
  'isearch:underline'
)

DISABLE_UNTRACKED_FILES_DIRTY=true

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

# Useful Functions
source "$ZDOTDIR/functions.zsh"

# Normal files to source
zsh_add_file "variables.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "user-aliases.zsh"
zsh_add_file "aws.zsh"
zsh_add_file "python-venv.zsh"
zsh_add_file "transient-prompt.zsh"

# Load all the plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "hlissner/zsh-autopair"

# uv and uvx python cli
eval "$(uv generate-shell-completion zsh)"

# set AWS Default Region to us-west-2
asr $AWS_DEFAULT_REGION

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
