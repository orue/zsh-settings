#!/usr/bin/env zsh

# Transient prompt
set-long-prompt() {
  PROMPT=$(starship prompt)
}

set-short-prompt() {
  if [[ $PROMPT != '%# ' ]]; then
    PROMPT=$(starship module character)
    zle .reset-prompt
  fi
}

precmd_functions+=(set-long-prompt)
zle-line-finish() {
  set-short-prompt
}

zle -N zle-line-finish

trap 'set-short-prompt; return 130' INT
