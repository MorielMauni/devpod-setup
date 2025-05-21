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

# Install packages
brew install \
  fzf \
  luarocks \
  npm \
  lazygit \
  bash-completion \
  astral-sh/uv/uv \

# Optional: Set up fzf
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

# Aliases
cat << 'EOF' >> ~/.bashrc
alias gs='git status'
alias n='nvim'

# Kubectl
alias k='kubectl'
[[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

alias kcs='kubectl config use-context admin@homlab-staging'
alias kcp='kubectl config use-context admin@homelad-production'
alias kcontext='kubectl config use-context'

alias devpod='devpod-cli'

alias la='ls -la'
alias ll='ls -l'

EOF

source ~/.bashrc

echo "✅ All done!"
