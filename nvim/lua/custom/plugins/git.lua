return {
  {
    'kdheepak/lazygit.nvim',
    lazy = false,
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'APZelos/blamer.nvim',
  },
  {
    'tpope/vim-rhubarb',
    lazy = true,
  },
  {
    'wintermute-cell/gitignore.nvim',
    lazy = false,
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    lazy = false,
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
