local util = require 'config.util'

return {
  cmd = { util.executable 'ruff' or 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    'uv.lock',
    'requirements.txt',
    '.git',
  },
  init_options = {
    settings = {
      configurationPreference = 'filesystemFirst',
      fixAll = true,
      organizeImports = true,
      codeAction = {
        disableRuleComment = { enable = false },
        fixViolation = { enable = true },
      },
      lint = {
        enable = true,
      },
      format = {
        preview = false,
      },
    },
  },
}
