# ZSH Configuration

## Prompt Customization

The default configuration includes hostname in the prompt:

```
[user@hostname] ~/directory (git_branch)
➜
```

### Prompt Components

- **[user@hostname]** - Username and hostname in cyan
- **~/directory** - Current directory in blue
- **(git_branch)** - Git branch and status in yellow
  - ✓ = clean working directory
  - ✗ = uncommitted changes
- **➜** - Prompt character in green

### Customizing the Prompt

#### Option 1: Use the built-in custom theme

Create `~/.zshrc.local` and add:

```bash
# Use custom theme with hostname
ZSH_THEME="custom"
```

Then copy the custom theme to Oh My Zsh:
```bash
ln -sf ~/dotfiles/zsh/themes/custom.zsh-theme ~/.oh-my-zsh/custom/themes/custom.zsh-theme
```

#### Option 2: Customize in .zshrc.local

Create `~/.zshrc.local` and override the PROMPT variable:

```bash
# Minimal prompt without hostname
PROMPT='%{$fg[blue]%}%~%{$reset_color%} $(git_prompt_info)
%{$fg[green]%}➜%{$reset_color%} '

# Or use robbyrussell theme without modifications
ZSH_THEME="robbyrussell"
```

#### Option 3: Add timestamp to right prompt

Uncomment this line in `zshrc`:

```bash
RPROMPT='%{$fg[yellow]%}%T%{$reset_color%}'
```

### Short Hostname

To show only the short hostname (without domain):

```bash
# In .zshrc.local
PROMPT='%{$fg[cyan]%}[%n@%m]%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} $(git_prompt_info)
%{$fg[green]%}➜%{$reset_color%} '
```

`%m` = short hostname
`%M` = full hostname (FQDN)

### Hide Hostname

If you don't want hostname in the prompt, add to `~/.zshrc.local`:

```bash
# Simple prompt without hostname
PROMPT='%{$fg[blue]%}%~%{$reset_color%} $(git_prompt_info)
%{$fg[green]%}➜%{$reset_color%} '
```

## Platform-Specific Settings

### macOS (`zshrc.macos`)
- Homebrew integration (Intel and Apple Silicon)
- macOS-specific aliases (flushdns, showfiles, lock)
- Optional: Atuin, STM32, PlatformIO, ESP-IDF

### Linux (`zshrc.linux`)
- Debian/Ubuntu package management aliases
- Kali Linux specific tools
- Systemd service management
- Color ls/grep support

## Plugins

### Core Plugins (all platforms)
- git
- sudo

### macOS Additional
- macos
- brew
- docker

### Linux Additional
- debian
- systemd
- nmap

## Network Information Display

On shell startup, displays:
- Hostname
- WAN IP (with 2-second timeout)
- LAN IP addresses

To disable, comment out lines 82-99 in `zshrc`.

## Local Configuration

Create `~/.zshrc.local` for machine-specific settings that won't be tracked in git:

```bash
# Example ~/.zshrc.local

# Override theme
ZSH_THEME="agnoster"

# Add custom aliases
alias myserver='ssh user@server.com'

# Add custom paths
export PATH="$HOME/bin:$PATH"

# Environment variables
export CUSTOM_VAR="value"
```
