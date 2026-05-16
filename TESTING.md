# Testing Guide

## Manual Testing

### Test Installation Script

```bash
# Backup your current configs first!
cp ~/.zshrc ~/.zshrc.backup
cp ~/.tmux.conf ~/.tmux.conf.backup
cp ~/.gitconfig ~/.gitconfig.backup
cp -r ~/.config/nvim ~/.config/nvim.backup

# Run installation
cd ~/dotfiles
./scripts/install.sh

# Verify installation
ls -la ~/.zshrc ~/.tmux.conf ~/.gitconfig ~/.config/nvim
```

### Test ZSH Configuration

```bash
# Test config loads without errors
/bin/zsh -c 'source ~/dotfiles/zsh/zshrc && echo "✓ Config loaded"'

# Test platform detection
/bin/zsh -c 'source ~/dotfiles/zsh/zshrc && echo "Platform: $DOTFILES_OS"'

# Test prompt shows hostname
/bin/zsh -c 'source ~/dotfiles/zsh/zshrc && echo $PROMPT'

# Open new shell to see the prompt
exec zsh
```

### Test Prompt Appearance

The prompt should look like:
```
[user@hostname] ~/directory (git_branch ✓)
➜
```

### Test Git Configuration

```bash
git config --list | grep -E "user\.|alias\.|color\."
git config user.name "Your Name"
git config user.email "your@email.com"
```

### Test Tmux Configuration

```bash
# Start tmux
tmux

# Test keybindings:
# Ctrl+b then | - split vertical
# Ctrl+b then - - split horizontal
# Alt+Arrow - move between panes
# Ctrl+b then r - reload config
```

### Test Neovim Configuration

```bash
nvim
# Inside nvim run:
:Lazy sync
:checkhealth
```

## Platform-Specific Testing

### macOS

```bash
# Verify Homebrew paths
echo $PATH | grep homebrew

# Test macOS aliases
type flushdns
type showfiles
type brewup
```

### Linux

```bash
# Verify apt aliases
type update
type install

# Test systemd aliases
type sstart
type sstatus
```

## Automated Testing (GitHub Actions)

Push to repository to trigger tests:

```bash
cd ~/dotfiles
git add .
git commit -m "Test changes"
git push
```

Check GitHub Actions tab for test results.

## Rollback

If something goes wrong:

```bash
# Restore backups
mv ~/.zshrc.backup ~/.zshrc
mv ~/.tmux.conf.backup ~/.tmux.conf
mv ~/.gitconfig.backup ~/.gitconfig
rm -rf ~/.config/nvim && mv ~/.config/nvim.backup ~/.config/nvim

# Reload shell
exec zsh
```
