return function()
  local snacks = require 'snacks'

  snacks.setup {
    bigfile = { enabled = true },
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = false,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  }
end
