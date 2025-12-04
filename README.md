# Production-Ready ZSH Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![ZSH Version](https://img.shields.io/badge/zsh-5.0+-blue.svg)](https://www.zsh.org/)
[![macOS](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](https://en.wikipedia.org/wiki/MacOS)

A comprehensive, optimized ZSH configuration tailored for **developers and DevOps engineers**. Features smart environment switching, container/Kubernetes shortcuts, Python/Go support, and production-grade performance optimizations.

**Perfect for:** Python developers, Go developers, DevOps engineers, and anyone who spends time in the terminal.

## 🌟 Key Features

### Development Productivity
- ⚡ **Optimized Startup**: ~100-200ms with intelligent caching strategies
- 🎨 **Starship Prompt**: Fast, customizable prompt with transient mode
- 🔧 **Smart Tool Management**: Auto-switching for Node versions (NVM) and Python virtual environments
- 📦 **Language Support**: First-class support for Python (uv), Go, Node.js, and Lua
- 🎯 **40+ Productivity Aliases**: Optimized shortcuts for common workflows

### DevOps & Container Management
- 🐳 **Docker Aliases**: Quick shortcuts for containers, images, and compose operations
- ☸️ **Kubernetes Support**: kubectl shortcuts and pod management commands
- 🔍 **System Monitoring**: Modern replacements for netstat, disk usage analysis, process search
- 📊 **Performance Tools**: Network analysis, system stats, port inspection

### Safety & Reliability
- 🔒 **Smart History Filtering**: Prevents accidental storage of sensitive commands
- ✅ **Error Resilience**: Function existence checks prevent startup failures
- 🛡️ **Safe File Operations**: Interactive cp/mv/rm by default
- 🔧 **Robust Plugin Management**: Automatic GitHub plugin installation and updates

### Code Quality
- 🚀 **Plugin System**: Automatic plugin downloading from GitHub
- 📝 **Comprehensive Documentation**: Detailed inline comments and OPTIMIZATION_SUMMARY.md
- 🎨 **Semantic Color System**: Consistent, maintainable color scheme throughout
- 🧹 **Clean Codebase**: Consolidated functions, no redundancy, DRY principles

## 📦 What's Included

### Shells & Scripting
- NVM lazy-loading with auto-switching on `.nvmrc` changes
- Python venv auto-activation (supports both `venv/` and `.venv/`)
- Conda lazy-loading
- Go environment configuration with security checks

### Aliases & Shortcuts
```
Navigation:    notes, docs, desk, dev, github, conf
Docker:        d, dlc, dx, dip, dls, dps, dc, dcup, dcd
Kubernetes:    k, kgp, kdesc
Python (uv):   uvs, uvr, uvi, uvl, uvp, uvx
Git:           zshrc, zshconf, ghweb
System:        ls, ll, la, lt, df, du, usage, ss, psgrep
Files:         cp, mv, rm, mkdir, mkdir, extract, mkarchive
Dev:           nvim, vim (alias to neovim)
```

### Utility Functions
```
fzf_edit              # Fuzzy find and edit files
svim <file>           # Edit files with sudo + nvim config
reload                # Reload ZSH configuration
mcd <dir>             # Create directory and cd into it
extract <file>        # Smart archive extraction (tar, zip, 7z, etc.)
mkarchive <dir>       # Create tar.gz archive
go-fmt                # Format, lint, and check Go code
go-vulncheck          # Security vulnerability scanning
go-coverage           # Test coverage reports
list_aliases          # Display all aliases with colors
tree [level]          # Show directory tree with eza
active-repos [days]   # Find repositories with recent commits
localip               # Get local IP address
sys-stats             # Quick system statistics
```

## 🚀 Quick Start

### Prerequisites

- **macOS** (10.14+) with Homebrew, or **Linux** with package manager
- **ZSH** 5.0+ (pre-installed on macOS)
- **Git** for cloning

### Installation (5 minutes)

```bash
# 1. Install required packages
brew bundle install --file=~/.config/zsh/Brewfile

# 2. Set ZSH configuration directory
echo 'ZDOTDIR=$HOME/.config/zsh' > ~/.zshenv

# 3. Clone this repository
git clone https://github.com/yourusername/zsh-config.git ~/.config/zsh

# 4. Reload shell
exec zsh
```

**That's it!** Your shell is now configured with all features enabled.

### Manual Package Installation

If you prefer to install packages manually:

```bash
# Core development tools
brew install starship eza fzf bat neovim git gh

# Languages & package managers
brew install go nvm uv

# Utilities
brew install curl jq unrar p7zip

# Optional: Databases
brew install sqlite libpq
```

## 📚 Detailed Configuration

### Environment Auto-Switching

#### Node.js Version Management
When you enter a directory with `.nvmrc` or `.node-version`:
```bash
cd my-project
# → Activating v18.16.0
npm install
```

#### Python Virtual Environment
When you enter a directory with `venv/` or `.venv/`:
```bash
cd my-python-project
# → Activating virtual environment (my-python-project)
source .venv/bin/activate  # Already done automatically
```

### Using UV (Modern Python Package Manager)

```bash
uvs                  # uv sync - sync dependencies
uvr pytest           # uv run - run commands in venv
uvi requests         # uv pip install - install packages
uvl                  # uv lock - create lock file
uvp list             # uv python - manage Python versions
uvx ruff check .     # uvx - run tools without install
```

### Docker & Container Management

```bash
d ps                 # docker ps
dlc                  # Show last container
dx <container> bash  # Execute into container
dips                 # Inspect last container
dc up -d             # docker compose up (detached)
dcup                 # Show container ports
dcd                  # docker compose down
```

### Kubernetes Operations

```bash
k get pods           # Get all pods (uses kubectl)
kgp -A               # Get pods across all namespaces
kdesc pod <name>     # Describe a pod
k apply -f file.yaml # Apply configuration
```

### Go Development

```bash
go-fmt               # Format and lint code
go-vulncheck         # Security vulnerability scan
go-coverage          # Generate coverage reports
go-new myproject     # Create new Go module with structure
go-diagnose          # Show Go environment info
go-clean-deps        # Clean build cache
```

## ⚙️ Configuration Files

```
~/.config/zsh/
├── .zshrc                      # Main configuration (startup, plugins, hooks)
├── .zshenv                     # Environment variables and PATH setup
├── aliases.zsh                 # All aliases (navigation, docker, k8s, etc.)
├── colors.zsh                  # Catppuccin Frappe color scheme + semantic vars
├── exports.zsh                 # PATH, EDITOR, language-specific exports
├── functions.zsh               # 15+ utility functions (well-documented)
├── go.zsh                       # Go development tools and functions
├── nvm.zsh                      # Node Version Manager (lazy-loaded)
├── python-venv.zsh             # Python virtual environment auto-activation
├── transient-prompt.zsh        # Transient prompt mode (requires starship)
├── user-aliases.zsh            # User-specific aliases (auto-loaded)
├── starship.toml               # Starship prompt configuration
├── Brewfile                    # Homebrew package definitions
├── README.md                   # This file
└── plugins/                    # Auto-managed ZSH plugins
    ├── zsh-autosuggestions/    # Command suggestions from history
    ├── zsh-history-substring-search/  # Search history with arrow keys
    ├── zsh-autopair/           # Auto-close brackets and quotes
    └── zsh-syntax-highlighting # Syntax highlighting (must be last)
```

## 🎯 Performance Optimizations

This configuration is optimized for startup speed and responsiveness:

| Optimization | Strategy | Impact |
|--------------|----------|--------|
| Completion Caching | 20-hour rebuild cycle | ~50ms faster startup |
| Command Caching | Cache fzf, uv, uvx completions | ~30ms faster on cold start |
| Lazy Loading | NVM and Conda load on-demand | Skip init if not used |
| PATH Deduplication | Automatic removal of duplicates | Cleaner environment |
| Function Consolidation | Minimal plugin count | Better maintainability |
| Conditional Loading | Load only if command exists | Fail-safe startup |

**Expected Startup Time:** 100-200ms (cold shell)

## 🔧 Optional Features

### Async Plugin Loading (Advanced Users)

For faster startup on systems with heavy plugins:

```bash
# Enable in ~/.zshenv or at shell startup:
export ENABLE_ASYNC_PLUGINS=true

# Then install zsh-defer:
git clone https://github.com/romkatv/zsh-defer ~/.config/zsh/plugins/zsh-defer
```

⚠️ **Note:** Disabled by default. Standard synchronous loading is recommended and faster in most cases.

### Debug Mode

Enable detailed logging for troubleshooting:

```bash
export DEBUG_MODE=1
exec zsh
```

This shows logs for NVM and Python venv auto-switching.

## 🐛 Troubleshooting

### Shell Not Loading Configuration

```bash
# Check ZDOTDIR is set correctly
echo $ZDOTDIR
# Should output: /Users/yourusername/.config/zsh

# Verify .zshenv exists in home directory
cat ~/.zshenv
# Should contain: ZDOTDIR=$HOME/.config/zsh
```

### Starship Prompt Not Working

```bash
# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Or via Homebrew
brew install starship
```

### Plugin Errors

```bash
# Update all plugins
zsh-update-plugins

# Or update individual plugin
git -C ~/.config/zsh/plugins/zsh-autosuggestions pull
```

### Completion Not Working

```bash
# Rebuild completion dump
rm ~/.config/zsh/.zcompdump*
exec zsh
```

## 📖 Documentation

- **Inline Comments** - Every function and alias is documented
- **File Headers** - Each configuration file explains its purpose

## 🔄 Updating

### Update Plugins
```bash
zsh-update-plugins
```

### Update Homebrew Packages
```bash
brew update && brew upgrade
```

### Update This Configuration
```bash
cd ~/.config/zsh
git pull
```

## 🛠️ Customization

### Add Personal Aliases

Edit `~/.config/zsh/user-aliases.zsh`:

```bash
# Example: Add your own aliases
alias myapp='~/.local/bin/myapp'
alias proj='cd ~/projects/my-project'
```

### Change Starship Theme

Edit `~/.config/zsh/starship.toml`:

```toml
format = """$directory$git_branch$git_status$line_break$character"""
```

See [Starship documentation](https://starship.rs/) for options.

### Customize Colors

Edit `~/.config/zsh/colors.zsh` to change the color scheme. Currently uses Catppuccin Frappe.

## 📋 Requirements

### Supported Platforms
- ✅ macOS 10.14+ (Intel & Apple Silicon)
- ✅ Linux (Ubuntu, Fedora, Arch, etc.)
- ❌ Windows (WSL untested, may work)

### Required Versions
- ZSH 5.0+
- Homebrew (macOS)
- Git 2.0+

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 🔗 Built With

- [Starship](https://starship.rs/) - Cross-shell prompt
- [EZA](https://github.com/eza-community/eza) - Modern ls replacement
- [FZF](https://github.com/junegunn/fzf) - Fuzzy finder
- [ZSH](https://www.zsh.org/) - Shell

---

**Happy shell-ing! 🚀**

Made with ❤️ for developers and DevOps engineers.
