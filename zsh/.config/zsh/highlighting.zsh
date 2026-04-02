(( ${+ZSH_PLUGIN_BUNDLE_ACTIVE} && ZSH_PLUGIN_BUNDLE_ACTIVE )) && return

() {
  emulate -L zsh

  local candidate

  for candidate in \
    /opt/homebrew/share/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh \
    /usr/local/share/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh \
    "${XDG_DATA_HOME:-$HOME/.local/share}/zinit/plugins/zdharma-continuum---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/zinit/plugins/zsh-users---zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  do
    if [[ -r "$candidate" ]]; then
      source "$candidate"
      break
    fi
  done
}
