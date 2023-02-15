return {
  {
    -- add pyright to lspconfig
    {
      "neovim/nvim-lspconfig",
      ---@class PluginLspOpts
      opts = {
        ---@type lspconfig.options
        servers = {
          -- pyright will be automatically installed with mason and loaded with lspconfig
          pyright = {},
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.autoflake,
          nls.builtins.formatting.autopep8,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}
