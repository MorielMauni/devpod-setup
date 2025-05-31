#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CORE_TAP_DIR="/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core"

if git -C "$CORE_TAP_DIR" rev-parse --is-shallow-repository | grep -q true; then
  echo "📦 Unshallowing homebrew-core tap (this may take a few minutes)..."
  git -C "$CORE_TAP_DIR" fetch --unshallow
else
  echo "homebrew-core is already unshallowed"
fi

echo "Updating Homebrew"
brew update
brew upgrade || true

brew install \
  fzf \
  luarocks \
  npm \
  lazygit \
  bash-completion \
  tmux || true

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

echo "Linking dotfiles"
backup_and_link .bashrc ~/.bashrc
backup_and_link .tmux.conf ~/.tmux.conf

if [[ -f "$SCRIPT_DIR/nvim.sh" ]]; then
  echo "Running Neovim setup"
  bash "$SCRIPT_DIR/nvim.sh"
else
  echo "Skipping Neovim setup (nvim.sh not found)"
fi

echo "Setup complete"
