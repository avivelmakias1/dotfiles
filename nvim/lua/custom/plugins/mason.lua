return {
  {
    -- Optional
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        -- lua stuff
        'stylua',

        -- web dev stuff
        -- 'deno',
        'prettierd',

        -- python stuff
        'ruff',
        'black',
        'isort',
        'debugpy',
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'lua_ls',
        'cssls',
        'html',
        'pyright',
        'ruff_lsp',
        'tsserver',
      },
    },
  }, -- Optional
}
