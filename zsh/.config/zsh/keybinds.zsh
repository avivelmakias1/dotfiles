autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
bindkey '^[w' kill-region

_sudo_replace_buffer() {
  local old="$1"
  local new="$2"
  local spacer="${2:+ }"

  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${spacer}${BUFFER#$old }"
    CURSOR=${#new}
  else
    LBUFFER="${new}${spacer}${LBUFFER#$old }"
  fi
}

sudo-command-line() {
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  local leading_space=''
  if [[ ${LBUFFER[1]} == ' ' ]]; then
    leading_space=' '
    LBUFFER="${LBUFFER# }"
  fi

  local editor_cmd="${SUDO_EDITOR:-${VISUAL:-$EDITOR}}"
  local typed_cmd="${${(Az)BUFFER}[1]}"
  local real_cmd="${${(Az)aliases[$typed_cmd]}[1]:-$typed_cmd}"
  local editor_head="${${(Az)editor_cmd}[1]}"

  if [[ -z "$editor_cmd" ]]; then
    case "$BUFFER" in
      sudo\ -e\ *) _sudo_replace_buffer 'sudo -e' '' ;;
      sudo\ *) _sudo_replace_buffer 'sudo' '' ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
    zle redisplay
    return
  fi

  if [[ "$real_cmd" == (\$EDITOR|$editor_head|${editor_head:c}) \
    || "${real_cmd:c}" == ($editor_head|${editor_head:c}) ]] \
    || builtin which -a "$real_cmd" | command grep -Fx -q "$editor_head"; then
    _sudo_replace_buffer "$typed_cmd" 'sudo -e'
  else
    case "$BUFFER" in
      $editor_head\ *) _sudo_replace_buffer "$editor_head" 'sudo -e' ;;
      \$EDITOR\ *) _sudo_replace_buffer '$EDITOR' 'sudo -e' ;;
      sudo\ -e\ *) _sudo_replace_buffer 'sudo -e' "$editor_cmd" ;;
      sudo\ *) _sudo_replace_buffer 'sudo' '' ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  fi

  LBUFFER="${leading_space}${LBUFFER}"
  zle redisplay
}

zle -N sudo-command-line
bindkey -M emacs '\e\e' sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M viins '\e\e' sudo-command-line
