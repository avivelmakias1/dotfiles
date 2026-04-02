() {
  emulate -L zsh

  local nvm_script=''
  local candidate=''
  local cmd

  for candidate in /opt/homebrew/opt/nvm/nvm.sh /usr/local/opt/nvm/nvm.sh "$NVM_DIR/nvm.sh"; do
    if [[ -r "$candidate" ]]; then
      nvm_script="$candidate"
      break
    fi
  done

  if [[ -n "$nvm_script" ]]; then
    typeset -g ZSH_NVM_SCRIPT="$nvm_script"

    _lazy_load_nvm() {
      local script="${ZSH_NVM_SCRIPT:-}"
      unset -f _lazy_load_nvm nvm node npm npx yarn corepack
      [[ -r "$script" ]] || return 127
      source "$script" --no-use
    }

    for cmd in nvm node npm npx yarn corepack; do
      eval "$cmd() { _lazy_load_nvm; $cmd \"\$@\"; }"
    done
  fi
}

if [[ "${TERM:-}" != dumb ]] && command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="${STARSHIP_CONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml}"
  [[ -r "$STARSHIP_CONFIG" ]] || export STARSHIP_CONFIG="$ZSH_DOTFILES_DIR/.config/starship.toml"
  export STARSHIP_CACHE="${STARSHIP_CACHE:-$ZSH_CACHE_DIR/starship}"
  command mkdir -p "$STARSHIP_CACHE" 2>/dev/null
  eval "$(starship init zsh)"
fi

for fzf_shell in \
  /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
  /usr/local/opt/fzf/shell/key-bindings.zsh
do
  [[ -r "$fzf_shell" ]] && source "$fzf_shell" 2>/dev/null && break
done
unset fzf_shell

for fzf_completion in \
  /opt/homebrew/opt/fzf/shell/completion.zsh \
  /usr/local/opt/fzf/shell/completion.zsh
do
  [[ -r "$fzf_completion" ]] && source "$fzf_completion" 2>/dev/null && break
done
unset fzf_completion

if [[ -z "${DISABLE_ZOXIDE:-}" ]] && command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

for command_not_found_handler in \
  /opt/homebrew/Library/Homebrew/command-not-found/handler.sh \
  /usr/local/Homebrew/Library/Homebrew/command-not-found/handler.sh \
  /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
  /usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
do
  if [[ -r "$command_not_found_handler" ]]; then
    source "$command_not_found_handler"
    break
  fi
done
unset command_not_found_handler
