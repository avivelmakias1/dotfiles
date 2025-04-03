return {
  {
    'williamboman/mason.nvim',
    tag = 'stable',
    lazy = false,
    config = true,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      local ensure_installed = vim.tbl_keys {}
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'pyright',
        'black',
        'debugpy',
        'eslint_d',
        'isort',
        'prettier',
        'shfmt',
        'sqlfmt',
        'taplo',
        'vtsls',
        'yamlfmt',
        'yamllint',
        -- hobby
        'gopls',
        'goimports-reviser',
        'golines',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    end,
  },
}
