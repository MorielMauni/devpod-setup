
#!/usr/bin/env bash

set -e

# CONFIG
REPO_URL="https://github.com/MorielMauni/nvim-dotfiles"
CONFIG_DIR="$HOME/.config/nvim"
TEMP_DIR="$HOME/.nvim-dotfiles-tmp"

echo "[+] Installing dependencies..."
if command -v apt &> /dev/null; then
    sudo apt update && sudo apt install -y git neovim
elif command -v pacman &> /dev/null; then
    sudo pacman -Syu --noconfirm git neovim
elif command -v dnf &> /dev/null; then
    sudo dnf install -y git neovim
else
    echo "Unsupported package manager. Install git and neovim manually."
    exit 1
fi

echo "[+] Cloning or updating repo..."
if [ -d "$TEMP_DIR" ]; then
    git -C "$TEMP_DIR" pull
else
    git clone "$REPO_URL" "$TEMP_DIR"
fi

echo "[+] Backing up old Neovim config if it exists..."
if [ -d "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
    mv "$CONFIG_DIR" "${CONFIG_DIR}.backup.$(date +%s)"
fi

echo "[+] Symlinking config..."
ln -s "$TEMP_DIR" "$CONFIG_DIR"

echo "[+] Launching Neovim to install plugins..."
nvim --headless "+Lazy! sync" +qa

echo "[✓] Neovim config installed and plugins synced!"
