# GitHub Actions CI/CD

## Workflow: Test Dotfiles Installation

This workflow automatically tests the dotfiles installation script on multiple platforms.

### Triggers

- **Push** to `main` or `develop` branches
- **Pull requests** to `main` branch
- **Manual trigger** via GitHub Actions UI (workflow_dispatch)

### Test Jobs

#### 1. test-macos
Tests installation on macOS runners (latest macOS version)

**Steps:**
- Checkout repository
- Install Oh My Zsh
- Run `install.sh` script
- Verify symlinks created (.zshrc, .tmux.conf, .config/nvim, .gitconfig)
- Test ZSH config loads without errors
- Test platform detection (should detect "macos")
- Test macOS-specific config loaded (verify aliases)
- Scan for secrets in repository
- Test Git configuration

#### 2. test-debian
Tests installation on Ubuntu/Debian runners (latest Ubuntu LTS)

**Steps:**
- Checkout repository
- Install ZSH and dependencies
- Install Oh My Zsh
- Run `install.sh` script
- Verify symlinks created
- Test ZSH config loads without errors
- Test platform detection (should detect "linux")
- Test Linux-specific config loaded (verify aliases)
- Scan for secrets in repository
- Test Git configuration
- Test Rust installation

#### 3. test-syntax
Tests shell script syntax and repository structure

**Steps:**
- Checkout repository
- Install shellcheck
- Validate shell script syntax
- Check for bash syntax errors
- Verify required files exist

### Running Tests Locally

#### Test macOS installation (macOS only):
```bash
cd ~/dotfiles
./scripts/install.sh
```

#### Test ZSH config loads:
```bash
/bin/zsh -c 'source ~/dotfiles/zsh/zshrc && echo "Config loaded successfully"'
```

#### Check for secrets:
```bash
cd ~/dotfiles
grep -r -i "password\|secret.*=\|api[_-]key.*=" . --exclude-dir=.git --exclude="*.md"
```

#### Validate shell scripts:
```bash
# Install shellcheck if not present
brew install shellcheck  # macOS
# or
sudo apt install shellcheck  # Linux

# Check scripts
shellcheck scripts/*.sh
```

### Status Badge

Add this badge to your README to show CI status:

```markdown
![CI Status](https://github.com/yourusername/dotfiles/workflows/Test%20Dotfiles%20Installation/badge.svg)
```

### Troubleshooting

**Failed symlink verification:**
- Check if Oh My Zsh was installed correctly
- Verify `install.sh` has execute permissions
- Check if required directories exist

**Platform detection failed:**
- Verify `OSTYPE` environment variable
- Check if platform-specific configs exist

**Secrets detected:**
- Review the grep output
- Move secrets to `.zshrc.local` (not tracked)
- Update `.gitignore` if needed

**ZSH config fails to load:**
- Check for syntax errors in zshrc files
- Verify Oh My Zsh is installed
- Test with: `/bin/zsh -n ~/dotfiles/zsh/zshrc` (syntax check only)
