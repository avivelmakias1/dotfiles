if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
else
  alias ls='ls -G'
fi

alias vim='nvim'
alias c='clear'

alias g='git'
alias ga='git add'
alias gc='git commit --verbose'
alias gd='git diff'
alias gco='git checkout'
alias gst='git status -sb'

if command -v kubectl >/dev/null 2>&1; then
  alias k='kubectl'
  alias kcgc='kubectl config get-contexts'
  alias kcuc='kubectl config use-context'
  alias kcn='kubectl config set-context --current --namespace'
  alias kl='kubectl logs'
  alias kpf='kubectl port-forward'
fi

command -v kubectx >/dev/null 2>&1 && alias kctx='kubectx'
command -v kubens >/dev/null 2>&1 && alias kns='kubens'
