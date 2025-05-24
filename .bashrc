# bash completion
[[ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]] && . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"

# Kubectl realated aliases
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

alias kcs='kubectl config use-context admin@homlab-staging'
alias kcp='kubectl config use-context admin@homelad-production'
alias kcontext='kubectl config use-context'

# DevPod aliases
alias devpod='devpod-cli'

# Mist
alias la='ls -la'
alias ll='ls -l'
alias gs='git status'
alias n='nvim'

# tmux aliases
export TERM=xterm-256color
  # Start tmux automatically
if [ -z "$TMUX" ] && command -v tmux &>/dev/null; then
  exec tmux
fi
