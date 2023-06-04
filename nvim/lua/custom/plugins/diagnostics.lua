return {
  {
    'weilbith/nvim-code-action-menu',
  },
  {
    'folke/trouble.nvim',
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      local lsp_lines = require 'lsp_lines'
      vim.diagnostic.config { virtual_text = false }
      lsp_lines.setup()
    end,
  },
}
