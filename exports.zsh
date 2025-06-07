#!/usr/bin/env zsh

export STARSHIP_CONFIG=~/.config/zsh/starship.toml # Starship configuration file
export PATH="/opt/homebrew/bin:$PATH"              # Add Homebrew to the PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"    # Add libpq to the PATH
export XDG_CONFIG_HOME="$HOME/.config"

export TERM="xterm-256color"            # Terminal type
export EDITOR="nvim"                    # Default editor
export LANG=en_US.UTF-8                 # Default language
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE # Homebrew cleanup
export HOMEBREW_NO_ANALYTICS=TRUE       # Homebrew analytics
export PATH="$HOME/.local/bin":$PATH    # Add local bin to the PATH
export PATH="$HOME/.docker/bin:$PATH"   # Add Docker bin to the PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# nvm
export NVM_DIR="$HOME/.nvm"                                                                                      # NVM installation directory
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# if reloading, some env vars that are already set can interfere with nvm
if [ -n "$NVM_BIN" ]; then
  # `nvm deactivate` will cleanup any remaining env vars
  nvm deactivate --silent
fi

# Go
export GOROOT="/opt/homebrew/opt/go/libexec" # Go installation directory
export GOPATH=$HOME/go                       # Go workspace
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin    # Add Go to the PATH
