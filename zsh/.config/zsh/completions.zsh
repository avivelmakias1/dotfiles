_zsh_preview_dir() {
  if command -v eza >/dev/null 2>&1; then
    eza --all --color=always --group-directories-first --icons=always -- "$1"
  else
    command ls -lahG -- "$1"
  fi
}

() {
  emulate -L zsh

  local completion_dir
  local kubectl_bin
  local kubectl_completion="$ZSH_COMPLETION_DIR/_kubectl"

  mkdir -p "$ZSH_COMPLETION_DIR"
  typeset -g ZSH_COMPDUMP="${ZSH_COMPDUMP:-$ZSH_CACHE_DIR/zcompdump}"

  for completion_dir in /opt/homebrew/share/zsh/site-functions /usr/local/share/zsh/site-functions; do
    [[ -d "$completion_dir" ]] && fpath=("$completion_dir" $fpath)
  done

  kubectl_bin="$(command -v kubectl 2>/dev/null)"
  if [[ -n "$kubectl_bin" ]]; then
    fpath=("$ZSH_COMPLETION_DIR" $fpath)
    if [[ ! -s "$kubectl_completion" || "$kubectl_bin" -nt "$kubectl_completion" ]]; then
      command kubectl completion zsh >| "$kubectl_completion" 2>/dev/null
    fi
  fi

  zstyle ':plugin:ez-compinit' compstyle zshzoo
  zstyle ':plugin:ez-compinit' use-cache yes
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  [[ -n "${LS_COLORS:-}" ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':completion:*' menu no
  zstyle ':fzf-tab:complete:cd:*' fzf-preview '_zsh_preview_dir "$realpath"'
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview '_zsh_preview_dir "$realpath"'

  if (( $+functions[run-compinit] )); then
    run-compinit
  else
    autoload -Uz compinit
    compinit -u -d "$ZSH_COMPDUMP"
  fi
}
