return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-jest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
          },
          require 'neotest-jest' {
            jestCommand = 'npx jest --',
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
    keys = {
      {
        '<leader>rtt',
        '<cmd>lua require("neotest").run.run()<cr>',
        desc = 'Run Closest Test',
      },
      {
        '<leader>rtf',
        '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>',
        desc = 'Run File Test',
      },
      {
        '<leader>rtd',
        '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>',
        desc = 'Run Debug Test',
      },
    },
  },
}
