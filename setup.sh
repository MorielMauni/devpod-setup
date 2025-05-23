#!/usr/bin/env bash
set -euo pipefail

brew update
brew install fzf luarocks npm lazygit bash-completion tmux
brew tap astral-sh/uv
brew install uv
