#!/usr/bin/env bash
set -euo pipefail

# Resolve repo root directory (absolute path)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Update and upgrade brew packages (skip unshallowing)
echo "📦 Updating Homebrew..."
brew update --force --quiet
brew upgrade || true

# Install brew packages
brew install \
  fzf \
  luarocks \
  npm \
  lazygit \
  bash-completion \
  tmux || true

# Install uv from astral-sh tap
brew tap astral-sh/uv || true
brew install uv || true

# Function to back up and link dotfiles
backup_and_link() {
  local src=$1
  local dest=$2
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -sf "$SCRIPT_DIR/$src" "$dest"
  echo "Linked $src → $dest"
}

# Link dotfiles
echo "🔗 Linking dotfiles..."
backup_and_link .bashrc ~/.bashrc
backup_and_link .tmux.conf ~/.tmux.conf

# Run Neovim setup if script exists
if [[ -f "$SCRIPT_DIR/nvim.sh" ]]; then
  echo "🚀 Running Neovim setup..."
  bash "$SCRIPT_DIR/nvim.sh"
else
  echo "Skipping Neovim setup (nvim.sh not found)"
fi

echo "✅ Setup complete"
