return {
  {
    'kdheepak/lazygit.nvim',
    event = 'VeryLazy',
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
  {
    'APZelos/blamer.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'tpope/vim-rhubarb',
    event = 'VeryLazy',
  },
  {
    'wintermute-cell/gitignore.nvim',
    event = 'VeryLazy',
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
