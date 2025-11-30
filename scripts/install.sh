#!/usr/bin/env bash

# Dotfiles Installation Script
# Supports macOS and Linux (Kali)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}=== Dotfiles Installation ===${NC}\n"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo -e "${YELLOW}Detected: macOS${NC}"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo -e "${YELLOW}Detected: Linux${NC}"
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Check if target exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing file: $target${NC}"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Create symlink
    ln -sf "$source" "$target"
    echo -e "${GREEN}✓${NC} Linked: $target → $source"
}

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Dotfiles directory not found at $DOTFILES_DIR${NC}"
    exit 1
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "\n${YELLOW}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}✓${NC} Oh My Zsh installed"
else
    echo -e "${GREEN}✓${NC} Oh My Zsh already installed"
fi

# Install platform-specific dependencies
if [[ "$OS" == "macos" ]]; then
    # Check for Homebrew
    if ! command -v brew &> /dev/null; then
        echo -e "\n${YELLOW}Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo -e "${GREEN}✓${NC} Homebrew installed"
    else
        echo -e "${GREEN}✓${NC} Homebrew already installed"
    fi

    # Install common tools
    echo -e "\n${YELLOW}Installing common tools via Homebrew...${NC}"
    brew install git tmux neovim ripgrep fd

elif [[ "$OS" == "linux" ]]; then
    echo -e "\n${YELLOW}Installing common tools...${NC}"
    sudo apt update
    sudo apt install -y git tmux neovim ripgrep fd-find build-essential curl
fi

# Create necessary directories
mkdir -p "$HOME/.config"

# Install ZSH configuration
echo -e "\n${YELLOW}Installing ZSH configuration...${NC}"
create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Install Tmux configuration
echo -e "\n${YELLOW}Installing Tmux configuration...${NC}"
create_symlink "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Install Neovim configuration
if [ -d "$DOTFILES_DIR/nvim/config" ]; then
    echo -e "\n${YELLOW}Installing Neovim configuration...${NC}"
    create_symlink "$DOTFILES_DIR/nvim/config" "$HOME/.config/nvim"
fi

# Install Git configuration
echo -e "\n${YELLOW}Installing Git configuration...${NC}"
create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

# Install custom ZSH theme
if [ -d "$HOME/.oh-my-zsh/custom/themes" ]; then
    echo -e "\n${YELLOW}Installing custom ZSH theme...${NC}"
    create_symlink "$DOTFILES_DIR/zsh/themes/custom.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/custom.zsh-theme"
fi

# Install Rust if not present
if ! command -v cargo &> /dev/null; then
    echo -e "\n${YELLOW}Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo -e "${GREEN}✓${NC} Rust installed"
else
    echo -e "${GREEN}✓${NC} Rust already installed"
fi

# Set ZSH as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "\n${YELLOW}Setting ZSH as default shell...${NC}"
    chsh -s "$(which zsh)"
    echo -e "${GREEN}✓${NC} ZSH set as default shell"
fi

# Final instructions
echo -e "\n${GREEN}=== Installation Complete! ===${NC}\n"
echo -e "Next steps:"
echo -e "  1. Set your Git user info:"
echo -e "     ${YELLOW}git config --global user.name \"Your Name\"${NC}"
echo -e "     ${YELLOW}git config --global user.email \"your@email.com\"${NC}"
echo -e ""
echo -e "  2. Create ${YELLOW}~/.zshrc.local${NC} for machine-specific config (optional)"
echo -e ""
echo -e "  3. Restart your shell or run: ${YELLOW}exec zsh${NC}"
echo -e ""
echo -e "  4. For Neovim, run ${YELLOW}:Lazy sync${NC} to install plugins"
echo -e ""
