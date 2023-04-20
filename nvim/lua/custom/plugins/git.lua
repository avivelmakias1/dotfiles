return {
  {
    'kdheepak/lazygit.nvim',
    event = "VeryLazy",
  },
  {
    'tpope/vim-fugitive',
    event = "VeryLazy",
  },
  {
    'APZelos/blamer.nvim',
    event = "VeryLazy",
  },
  {
    'tpope/vim-rhubarb',
    event = "VeryLazy",
  },
  {
    'wintermute-cell/gitignore.nvim',
    event = "VeryLazy",
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
