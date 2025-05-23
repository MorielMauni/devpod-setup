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

export TERM=xterm-256color

# Start tmux automatically
if [ -z "$TMUX" ] && command -v tmux &>/dev/null; then
  exec tmux
fi
