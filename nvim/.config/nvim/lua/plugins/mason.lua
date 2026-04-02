return function()
  require('mason').setup()

  require('mason-tool-installer').setup {
    ensure_installed = {
      'lua-language-server',
      'basedpyright',
      'ruff',
      'vtsls',
      'vue-language-server',
      'eslint-lsp',
      'debugpy',
      'js-debug-adapter',
      'stylua',
      'prettierd',
      'prettier',
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000,
  }
end
