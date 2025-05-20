#!/bin/bash
set -e

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Ensure brew is in PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Fix shallow clone to allow full updates
git -C /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core fetch --unshallow || true

# Tap required repos
brew tap fluxcd/tap

# Install packages
brew install \
  npm \
  lazygit \

# Optional: Set up fzf
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

echo "✅ All done!"
