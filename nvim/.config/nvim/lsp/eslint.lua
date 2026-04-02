local util = require 'config.util'

return {
  cmd = {
    util.executable 'vscode-eslint-language-server' or 'vscode-eslint-language-server',
    '--stdio',
  },
  before_init = function(params)
    if params.capabilities and params.capabilities.textDocument then
      params.capabilities.textDocument.diagnostic = nil
    end
  end,
  on_init = function(client)
    client.server_capabilities.diagnosticProvider = nil
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
    '.git',
  },
  settings = {
    workingDirectory = { mode = 'auto' },
    format = false,
    codeAction = {
      disableRuleComment = {
        enable = false,
      },
      showDocumentation = {
        enable = false,
      },
    },
  },
}
