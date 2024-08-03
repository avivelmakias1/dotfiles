-- fix none-ls and make it format prettierd with config file
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local lspconfig = require 'lspconfig'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        require('none-ls.diagnostics.eslint_d').with {
          cwd = function(params)
            -- falls back to root if return value is nil
            return lspconfig.util.root_pattern('nx.json', '.esprintrc', '.prettierrc')(params.bufname)
          end,
        },
        require('none-ls.formatting.eslint_d').with {
          cwd = function(params)
            -- falls back to root if return value is nil
            return lspconfig.util.root_pattern('nx.json', '.esprintrc', '.prettierrc')(params.bufname)
          end,
        },
        require('none-ls.code_actions.eslint_d').with {
          cwd = function(params)
            -- falls back to root if return value is nil
            return lspconfig.util.root_pattern('nx.json', '.esprintrc', '.prettierrc')(params.bufname)
          end,
        },
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort.with {
          extra_args = { '--profile', 'black' },
        },
        null_ls.builtins.formatting.shfmt,
        -- null_ls.builtins.formatting.taplo,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.sqlfmt,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.clang_format,
      },
    }
  end,
}
