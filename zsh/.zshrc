[[ -o interactive ]] || return

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

typeset -gU path fpath
typeset -gr ZSH_DOTFILES_DIR="${${(%):-%x}:P:h}"
typeset -g ZSH_CONFIG_DIR="${XDG_CONFIG_HOME}/zsh"

[[ -d "$ZSH_CONFIG_DIR" ]] || ZSH_CONFIG_DIR="$ZSH_DOTFILES_DIR/.config/zsh"
typeset -gr ZSH_CONFIG_DIR

typeset module
for module in env path history keybinds plugins completions integrations aliases highlighting; do
  [[ -r "$ZSH_CONFIG_DIR/$module.zsh" ]] && source "$ZSH_CONFIG_DIR/$module.zsh"
done
unset module

[[ -r "$ZSH_CONFIG_DIR/local.zsh" ]] && source "$ZSH_CONFIG_DIR/local.zsh"
