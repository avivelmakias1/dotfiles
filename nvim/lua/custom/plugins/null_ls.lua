return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-null-ls').setup {
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
          'lua-language-server',
          'stylua',
          'pyright',
          -- 'ruff',
          -- 'ruff_lsp',
          'isort',
          'black',
          'eslint_d',
          'prettierd',
          'typescript-language-server',
          'css-lsp',
          'html-lsp',
          'json-lsp',
        },
        automatic_installation = true,
        handlers = {},
      }
      require('null-ls').setup()
    end,
  },
}
