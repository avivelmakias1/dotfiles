typeset -g ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
if ! command mkdir -p "$ZSH_CACHE_DIR/completions" 2>/dev/null; then
  ZSH_CACHE_DIR="${TMPDIR:-/tmp}/${USER:-zsh}-zsh-cache"
  command mkdir -p "$ZSH_CACHE_DIR/completions" 2>/dev/null
fi

typeset -gr ZSH_CACHE_DIR
typeset -gr ZSH_COMPLETION_DIR="$ZSH_CACHE_DIR/completions"
typeset -gr ZSH_PLUGIN_FILE="${ZSH_CONFIG_DIR}/plugins.txt"
typeset -gr ZSH_PLUGIN_BUNDLE="$ZSH_CACHE_DIR/plugins.zsh"

export VISUAL="${VISUAL:-nvim}"
export EDITOR="${EDITOR:-$VISUAL}"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
export PNPM_HOME="${PNPM_HOME:-$HOME/Library/pnpm}"

[[ -r "${ZSH_CONFIG_DIR}/local.env.zsh" ]] && source "${ZSH_CONFIG_DIR}/local.env.zsh"
