# Dotfiles

Cross-platform dotfiles for macOS and Linux (Kali) systems.

## Features

- **ZSH**: Oh My Zsh configuration with platform detection
- **Tmux**: Mouse support, vi mode, sensible defaults
- **Neovim**: Lua-based config with Rust tooling, LSP, and modern plugins
- **Git**: LFS support and common aliases
- **Rust**: Cargo environment setup
- **Platform-specific**: Auto-detects macOS vs Linux and loads appropriate configs

## Structure

```
dotfiles/
├── zsh/
│   ├── zshrc              # Main zsh config
│   ├── zshrc.macos        # macOS-specific additions
│   └── zshrc.linux        # Linux-specific additions
├── tmux/
│   └── tmux.conf          # Tmux configuration
├── nvim/
│   └── config/            # Neovim configuration
├── git/
│   └── gitconfig          # Git configuration (no personal info)
├── scripts/
│   ├── install.sh         # Installation script
│   └── bootstrap.sh       # Bootstrap Oh My Zsh and dependencies
└── README.md
```

## Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

## Manual Installation

1. **ZSH**:
   ```bash
   ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
   ```

2. **Tmux**:
   ```bash
   ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
   ```

3. **Neovim**:
   ```bash
   ln -sf ~/dotfiles/nvim/config ~/.config/nvim
   ```

4. **Git**:
   ```bash
   ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
   # Then set your user info:
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

## Platform Support

- macOS (tested on macOS Sequoia)
- Linux (Kali Linux)

## Requirements

### macOS
- Homebrew
- Oh My Zsh

### Linux
- Oh My Zsh
- Build essentials

## Customization

Create a `.zshrc.local` file in your home directory for machine-specific customizations:

```bash
# ~/.zshrc.local
export CUSTOM_VAR="value"
alias custom="command"
```

This file will be automatically sourced if it exists and is not tracked in git.
