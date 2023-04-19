return {
  {
    'folke/which-key.nvim',
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      local keymaps = {
        mode = { 'n', 'v' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>b'] = { name = '+buffers' },
        ['<leader>f'] = { name = '+find' },
        ['<leader>fi'] = { name = '+find in' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>w'] = { name = '+workspaces' },
        ['<leader>q'] = { name = '+diagnostics' },
        ['<leader>l'] = { name = '+lsp' },
        ['<leader>t'] = { name = '+toggles' },
      }
      wk.register(keymaps)
    end,
  },
}
