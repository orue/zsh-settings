# My ZSH Configuration

A modern, feature-rich ZSH configuration optimized for development workflows with Git, Node.js, and Python support.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage Examples](#usage-examples)
- [File Structure](#file-structure)
- [Troubleshooting](#troubleshooting)
- [Uninstall](#uninstall)
- [Contributing](#contributing)
- [License](#license)

## Features

- **⚡ Optimized Startup**: Intelligent caching for brew, fzf, and completion scripts
- **🎨 Starship Prompt**: Fast, customizable prompt with transient mode for cleaner history
- **🔧 Smart Tool Management**: Auto-switching Node versions (NVM) and Python virtual environments
- **📦 Plugin System**: Automatic GitHub plugin installation and management
- **🚀 Lazy Loading**: NVM and Conda lazy load for faster shell startup
- **🎯 Navigation Shortcuts**: Quick access to common directories (dev, docs, downloads, etc.)
- **🔒 Security**: History filtering to prevent accidental storage of sensitive commands
- **🛠️ Utility Functions**: Archive/extract, fuzzy file editing, system updates, and more
- **📝 Well-Documented**: Comprehensive inline documentation for all functions

## Screenshots

![ZSH Prompt in Action](./img/terminal-img.jpg)

## Prerequisites

Before installation, ensure you have:

- **macOS** with Homebrew installed
- **ZSH shell** (version 5.0+, pre-installed on macOS)
- **Git** for cloning the repository

### Required Packages

This configuration requires the following packages. You can install them all at once using the provided Brewfile:

```sh
brew bundle install --file=~/.config/zsh/Brewfile
```

Or install manually:

```sh
# Terminal & Prompt
brew install starship eza fzf bat

# Development Tools
brew install git gh go neovim

# Utilities
brew install curl jq nvm uv

# Databases
brew install sqlite libpq

# Archive Support
brew install unrar p7zip
```

**Package Overview:**
- **starship**: Cross-shell prompt with customizable themes
- **eza**: Modern ls replacement with icons and git integration
- **fzf**: Fuzzy finder for files and commands
- **bat**: Cat with syntax highlighting
- **gh**: GitHub CLI
- **go**: Go programming language
- **neovim**: Modern vim-based text editor
- **jq**: JSON processor
- **nvm**: Node Version Manager
- **uv**: Fast Python package installer
- **sqlite**: SQLite database
- **libpq**: PostgreSQL client library
- **unrar**: RAR archive extraction
- **p7zip**: 7-Zip archive support

## Installation

### Option 1: Quick Install (Recommended)

1. Install all required packages using Brewfile:
```sh
brew bundle install --file=~/.config/zsh/Brewfile
```

2. Set ZSH configuration directory:
```sh
echo 'ZDOTDIR=$HOME/.config/zsh' > ~/.zshenv
```

3. Clone this repository:
```sh
git clone https://github.com/orue/zsh-settings.git ~/.config/zsh
```

4. Restart your terminal or run:
```sh
exec zsh
```

### Option 2: Manual Install

1. Install Homebrew (if not already installed):
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install required packages individually (see Prerequisites section)

3. Follow steps 2-4 from Option 1 above

## Usage Examples

### Key Aliases
```sh
# Quick config editing
zshrc                    # Edit .zshrc with nvim

# Password generation
gpass                    # Generate secure 20-char password

# Plugin management
zsh-update-plugins       # Update all ZSH plugins
```

### Useful Functions
```sh
reload                   # Reload ZSH configuration
fzf_edit                 # Fuzzy find and edit files
svim <file>              # Edit files with sudo while preserving nvim config
```

**Why svim is useful:**
When editing system files with `sudo nvim`, your personal nvim configuration (plugins, settings, keybindings) is normally not available because sudo changes the HOME directory to root's home. The `svim` function solves this by preserving your HOME environment variable, giving you access to your complete nvim setup even when editing protected files like `/etc/hosts` or other system configuration files.

## File Structure

```
.config/zsh/
├── Brewfile                    # Homebrew package definitions
├── .zshrc                      # Main ZSH configuration with optimized startup
├── .gitignore                  # Git ignore patterns
├── README.md                   # This file
├── aliases.zsh                 # General aliases
├── brew-cache-update.zsh       # Homebrew cache updater utility
├── colors.zsh                  # Color definitions (Catppuccin Frappe palette)
├── exports.zsh                 # Environment exports and PATH configuration
├── functions.zsh               # Custom utility functions (well-documented)
├── nvm.zsh                     # Node Version Manager with lazy loading
├── python-venv.zsh             # Python virtual environment auto-activation
├── starship.toml               # Starship prompt configuration
├── transient-prompt.zsh        # Transient prompt for cleaner history
├── user-aliases.zsh            # Personal aliases and navigation shortcuts
├── plugins/                    # ZSH plugins directory (auto-managed)
└── img/                        # Screenshots and assets
```

## Performance Optimizations

This configuration includes several optimizations for faster shell startup:

- **Completion Caching**: Compinit runs full checks only once per day
- **Command Output Caching**: FZF, UV, and UVX completions cached automatically
- **Lazy Loading**: NVM and Conda initialize only when first used
- **PATH Deduplication**: Automatic removal of duplicate PATH entries
- **Consolidated Hooks**: Single directory change hook instead of multiple
- **Conditional Loading**: Features load only when their commands are available

Expected startup time: **~100-200ms** on modern hardware.

## Troubleshooting

### Common Issues

**ZSH not loading configuration:**
```sh
# Verify ZDOTDIR is set
echo $ZDOTDIR
# Should output: /Users/yourusername/.config/zsh
```

**Starship prompt not working:**
```sh
# Install Starship if missing
curl -sS https://starship.rs/install.sh | sh
```

**Plugin errors:**
```sh
# Update plugins
zsh-update-plugins
```

### Compatibility

- **macOS**: Fully supported (both Apple Silicon and Intel)
- **Linux**: Compatible with most distributions
- **ZSH Version**: Requires 5.0 or higher

### Debug Mode

Enable debug logging for troubleshooting:

```sh
export DEBUG_MODE=1
exec zsh
```

This will show detailed logs for NVM and Python venv auto-switching.

## Uninstall

To remove this configuration:

1. Remove the configuration directory:
```sh
rm -rf ~/.config/zsh
```

2. Reset ZDOTDIR:
```sh
rm ~/.zshenv
```

3. Restart your terminal

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
