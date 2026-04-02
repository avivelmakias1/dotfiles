() {
  emulate -L zsh

  local antidote_script=''
  local candidate=''
  local legacy_root="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/plugins"

  mkdir -p "$ZSH_CACHE_DIR"
  typeset -g ZSH_PLUGIN_BUNDLE_ACTIVE=0

  for candidate in \
    /opt/homebrew/opt/antidote/share/antidote/antidote.zsh \
    /opt/homebrew/share/antidote/antidote.zsh \
    /usr/local/opt/antidote/share/antidote/antidote.zsh \
    /usr/local/share/antidote/antidote.zsh \
    "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
  do
    if [[ -r "$candidate" ]]; then
      antidote_script="$candidate"
      break
    fi
  done

  if [[ -r "$ZSH_PLUGIN_FILE" ]]; then
    if [[ ! -r "$ZSH_PLUGIN_BUNDLE" || "$ZSH_PLUGIN_FILE" -nt "$ZSH_PLUGIN_BUNDLE" ]] && [[ -n "$antidote_script" ]]; then
      (
        source "$antidote_script"
        antidote bundle <"$ZSH_PLUGIN_FILE" >| "$ZSH_PLUGIN_BUNDLE"
      ) >/dev/null 2>&1
    fi

    if [[ -r "$ZSH_PLUGIN_BUNDLE" ]]; then
      source "$ZSH_PLUGIN_BUNDLE"
      typeset -g ZSH_PLUGIN_BUNDLE_ACTIVE=1
      return
    fi
  fi

  [[ -r "$legacy_root/Aloxaf---fzf-tab/fzf-tab.plugin.zsh" ]] && source "$legacy_root/Aloxaf---fzf-tab/fzf-tab.plugin.zsh"
  [[ -r "$legacy_root/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$legacy_root/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh"
}
