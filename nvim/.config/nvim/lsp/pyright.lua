return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { 'python' },
  root_markers = {
    '.git',
    'setup.cfg',
    'requirements.txt',
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
