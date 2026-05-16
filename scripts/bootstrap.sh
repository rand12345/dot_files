#!/usr/bin/env bash

# Bootstrap script for setting up a new machine
# This script clones the dotfiles repo and runs the installation

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/yourusername/dotfiles.git}"
DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}=== Dotfiles Bootstrap ===${NC}\n"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git not found. Installing...${NC}"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - install Xcode command line tools
        xcode-select --install
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sudo apt update && sudo apt install -y git
    fi
fi

# Clone dotfiles if not already present
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}Cloning dotfiles repository...${NC}"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo -e "${YELLOW}Dotfiles directory already exists. Updating...${NC}"
    cd "$DOTFILES_DIR" && git pull
fi

# Run installation script
echo -e "\n${YELLOW}Running installation script...${NC}\n"
bash "$DOTFILES_DIR/scripts/install.sh"
