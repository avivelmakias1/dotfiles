return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    '.git',
    'setup.cfg',
    'requirements.txt',
    'ruff.toml',
    '.python-version',
  },
  settings = {
    basedpython = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
