return function()
  local wk = require 'which-key'

  wk.setup {
    delay = 300,
    icons = {
      mappings = vim.g.have_nerd_font,
    },
  }

  wk.add {
    { '<leader>c', group = 'Code' },
    { '<leader>d', group = 'Debug' },
    { '<leader>f', group = 'Find' },
    { '<leader>g', group = 'Git' },
    { '<leader>s', group = 'Search' },
    { '<leader>w', group = 'Window' },
  }
end
