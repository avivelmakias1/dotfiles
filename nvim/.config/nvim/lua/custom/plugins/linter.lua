return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      -- Your config will go here
      local lint = require("lint")
      lint.linters_by_ft = {
        -- javascript = {
        --   "eslint"
        -- },
        -- typescript = {
        --   "eslint"
        -- },
        -- javascriptreact = {
        --   "eslint"
        -- },
        -- typescriptreact = {
        --   "eslint"
        -- },
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
