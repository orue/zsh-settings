#!/usr/bin/env zsh

export STARSHIP_CONFIG=~/.config/zsh/starship.toml # Starship configuration file
export PATH="/opt/homebrew/bin:$PATH"              # Add Homebrew to the PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"    # Add libpq to the PATH

export TERM="xterm-256color"            # Terminal type
export EDITOR="nvim"                    # Default editor
export LANG=en_US.UTF-8                 # Default language
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE # Homebrew cleanup
export HOMEBREW_NO_ANALYTICS=TRUE       # Homebrew analytics
export PATH="$HOME/.local/bin":$PATH    # Add local bin to the PATH
export PATH="$HOME/.docker/bin:$PATH"   # Add Docker bin to the PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export UV_PYTHON=3.12 # Universal-ctags Python version

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"                                # Pyenv installation directory
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" # Add Pyenv to the PATH

# nvm
export NVM_DIR="$HOME/.nvm"                                                                                      # NVM installation directory
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Go
export GOROOT="/opt/homebrew/opt/go/libexec" # Go installation directory
export GOPATH=$HOME/dev/go                   # Go workspace
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin    # Add Go to the PATH

# FROM: https://medium.com/@gokayburuc/some-zsh-config-ideas-for-devs-652d01c8b56f
# Define an array of directories to add to PATH
# path=(
#     $path                           # Keep existing PATH entries
#     $HOME/bin
#     $HOME/.local/bin
#     $HOME/dotnet
#     $SCRIPTS
#     $HOME/.krew/bin
#     $HOME/.rd/bin                   # Rancher Desktop
#     # $HOME/*/bin(N)                # Add all bin directories under HOME
#     # /usr/local/*/bin(N)           # Add all bin directories under /usr/local
# )
# # Remove duplicate entries and non-existent directories
# typeset -U path
# path=($^path(N-/))
# # Export the updated PATH
# export PATH
