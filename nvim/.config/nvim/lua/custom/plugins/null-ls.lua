return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort.with {
          extra_args = { '--profile', 'black' },
        },
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.taplo,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.diagnostics.yamllint,
      },
    }
  end,
}
