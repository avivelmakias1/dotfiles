return {
  {
    'mhartington/formatter.nvim',
    config = function()
      -- Utilities for creating configurations
      local util = require 'formatter.util'

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require('formatter').setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require('formatter.filetypes.lua').stylua,
          },
          python = {
            require('formatter.filetypes.python').black,
            {
              exe = 'isort',
              args = { '-q', '-', '--profile=black' },
              stdin = true,
            },
          },

          javascript = {
            require('formatter.filetypes.javascript').prettierd,
            -- require('formatter.filetypes.javascript').eslint_d,
          },
          typescript = {
            require('formatter.filetypes.javascript').prettierd,
            -- require('formatter.filetypes.javascript').eslint_d,
          },
          javascriptreact = {
            require('formatter.filetypes.javascript').prettierd,
            -- require('formatter.filetypes.javascript').eslint_d,
          },
          typescriptreact = {
            require('formatter.filetypes.javascript').prettierd,
            -- require('formatter.filetypes.javascript').eslint_d,
          },

          toml = {
            require('formatter.filetypes.toml').taplo,
          },

          yaml = {
            require('formatter.filetypes.yaml').yamlfmt,
          },

          sh = {
            require('formatter.filetypes.sh').shfmt,
          },
          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      }
    end,
  },
}
