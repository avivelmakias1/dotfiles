return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      -- Your config will go here
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = {
          "eslint_d"
        },
        typescript = {
          "eslint_d"
        },
        javascriptreact = {
          "eslint_d"
        },
        typescriptreact = {
          "eslint_d"
        },
        python = {
          "mypy",
          -- "ruff"
        },
        lua = {
          "selene"
        }
      }
    end
  }
}
