return function()
  require('catppuccin').setup {
    flavour = 'frappe',
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    integrations = {
      blink_cmp = true,
      gitsigns = true,
      mason = true,
      native_lsp = {
        enabled = true,
        inlay_hints = {
          background = false,
        },
      },
      snacks = {
        enabled = true,
        indent_scope_color = 'lavender',
      },
      treesitter = true,
      which_key = true,
    },
  }

  vim.cmd.colorscheme 'catppuccin'
end
