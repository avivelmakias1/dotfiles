return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    event = 'VeryLazy',

    dependencies = {
      -- LSP Support
      {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy',
      }, -- Required
      {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',

        opts = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts)
          require('nvim-autopairs').setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp', event = 'VeryLazy' }, -- Required
      { 'hrsh7th/cmp-buffer', event = 'VeryLazy' }, -- Required
      { 'hrsh7th/cmp-path', event = 'VeryLazy' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy' }, -- Required
      { 'L3MON4D3/LuaSnip', event = 'VeryLazy' }, -- Required
    },
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',

    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    event = 'VeryLazy',
  },
  {
    'onsails/lspkind.nvim',
    event = 'VeryLazy',
  },
}
