# Ghostty Configuration

Ghostty is a fast, native terminal emulator. Configuration goes in `~/.config/ghostty/config`.

## Installation

macOS:
```bash
brew install --cask ghostty
```

Then symlink the config:
```bash
ln -sf ~/dotfiles/config/ghostty/config ~/.config/ghostty/config
```

## Configuration

Create your own `config` file in this directory with your preferred settings.

Example minimal config:
```
# Font
font-family = "JetBrains Mono"
font-size = 13

# Theme
theme = dark
background-opacity = 0.95

# Window
window-padding-x = 8
window-padding-y = 8

# Shell
shell-integration = true
```

For more options, see: https://github.com/ghostty-org/ghostty
