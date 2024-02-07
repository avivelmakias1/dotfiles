return {
  {
    'famiu/bufdelete.nvim',
  },
  -- {
  --   'akinsho/bufferline.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     options = {
  --       close_command = 'Bdelete! %d',
  --       diagnostics = 'nvim_lsp',
  --       always_show_bufferline = true,
  --       offsets = {
  --         {
  --           filetype = 'NvimTree',
  --           text = 'Nvim Tree',
  --           highlight = 'Directory',
  --           text_align = 'left',
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    'utilyre/barbecue.nvim',
    event = 'VeryLazy',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  },
  { 'kevinhwang91/nvim-bqf' },
}
