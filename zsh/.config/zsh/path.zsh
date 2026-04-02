typeset -gU path

path=(
  "$HOME/.local/bin"
  "$PNPM_HOME"
  "$HOME/Code/scripts"
  "/opt/homebrew/opt/postgresql@15/bin"
  $path
)

[[ -d "$PYENV_ROOT/shims" ]] && path=("$PYENV_ROOT/shims" $path)
[[ -d "$PYENV_ROOT/bin" ]] && path=("$PYENV_ROOT/bin" $path)

export PATH

[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
