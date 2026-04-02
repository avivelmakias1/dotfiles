local util = require 'config.util'

return {
  cmd = { util.executable 'basedpyright-langserver' or 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    'uv.lock',
    'requirements.txt',
    '.git',
  },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = 'standard',
        diagnosticMode = 'openFilesOnly',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
