#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

brew update
brew upgrade
brew install fzf luarocks npm lazygit bash-completion tmux || true
brew tap astral-sh/uv || true
brew install uv || true

backup_and_link() {
  local src=$1
  local dest=$2
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -sf "$SCRIPT_DIR/$src" "$dest"
}

backup_and_link .bashrc ~/.bashrc
backup_and_link .tmux.conf ~/.tmux.conf

bash "$SCRIPT_DIR/nvim.sh"

echo "Complete"
