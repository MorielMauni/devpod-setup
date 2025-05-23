#!/usr/bin/env bash
set -euo pipefail

# 1. Install/update packages with brew
echo "Installing/updating packages..."
brew update
brew upgrade
brew install fzf luarocks npm lazygit bash-completion tmux || true
brew tap astral-sh/uv || true
brew install uv || true

# 2. Copy or symlink dotfiles
echo "Linking dotfiles..."
# Example: backup existing and symlink
backup_and_link() {
  local src=$1
  local dest=$2
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -sf "$(pwd)/$src" "$dest"
}

backup_and_link .bashrc ~/.bashrc
backup_and_link .tmux.conf ~/.tmux.conf

# 3. Run Neovim setup script
echo "Running Neovim setup..."
bash ./nvim.sh

echo "complete"
