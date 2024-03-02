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
  {
    'folke/edgy.nvim',
    opts = {
      wo = {
        spell = false,
      },
      animate = {
        enabled = false,
      },
      bottom = {
        'Trouble',
        { ft = 'qf', title = 'QuickFix' },
        {
          ft = 'help',
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == 'help'
          end,
        },
      },
      left = {
        'NvimTree',
        { title = 'Spectre', ft = 'spectre_panel', size = { width = 0.3 } },
        { title = 'UndoTree', ft = 'undotree' },
      },
      right = {
        {
          title = 'CopilotChat.nvim',
          ft = 'copilot-chat',
          size = { width = 0.4 },
        },
        { title = 'Neotest Summary', ft = 'neotest-summary' },
        {
          ft = 'Outline',
          open = 'SymbolsOutlineOpen',
        },
        { title = 'hurl.nvim', ft = 'hurl-nvim', size = { width = 0.4 } },
        'aerial',
        'lspsagaoutline',
      },
    },
  },
}
