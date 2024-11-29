#!/usr/bin/env zsh

export STARSHIP_CONFIG=~/.config/zsh/starship.toml # Starship configuration file
export PATH="/opt/homebrew/bin:$PATH"              # Add Homebrew to the PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"    # Add libpq to the PATH

export PYENV_ROOT="$HOME/.pyenv"                                # Pyenv installation directory
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" # Add Pyenv to the PATH

export TERM="xterm-256color"            # Terminal type
export EDITOR="nvim"                    # Default editor
export LANG=en_US.UTF-8                 # Default language
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE # Homebrew cleanup
export HOMEBREW_NO_ANALYTICS=TRUE       # Homebrew analytics
export PATH="$HOME/.local/bin":$PATH    # Add local bin to the PATH
export PATH="$HOME/.docker/bin:$PATH"   # Add Docker bin to the PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export GOROOT="/opt/homebrew/opt/go/libexec" # Go installation directory
export GOPATH=$HOME/go                       # Go workspace
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin    # Add Go to the PATH
