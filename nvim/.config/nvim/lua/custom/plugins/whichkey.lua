return {
  {
    'folke/which-key.nvim',
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      wk.add {
        { '<leader>c', group = '+code' },
        { '<leader>c', group = '+code' },
        { '<leader>d', group = '+debug' },
        { '<leader>b', group = '+buffers' },
        { '<leader>f', group = '+find' },
        { '<leader>fi', group = '+find in' },
        { '<leader>g', group = '+git' },
        { '<leader>w', group = '+workspaces' },
        { '<leader>q', group = '+diagnostics' },
        { '<leader>l', group = '+lsp' },
        { '<leader>t', group = '+toggles' },
      }
    end,
  },
}
