return {
  "AckslD/swenv.nvim",
  opts = function(_, opts)
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    opts.get_venvs = function(venvs_path)
      return require("swenv.api").get_venvs(venvs_path)
    end
    -- Path passed to `get_venvs`.
    opts.venvs_path = vim.fn.expand("~/venvs")
    -- Something to do after setting an environment
    opts.post_set_venv = function(venv)
      vim.cmd("LspRestart")
      vim.cmd("DapLoadLaunchJSON")
    end
  end,
  keys = {
    { "<leader>cv", ":lua require('swenv.api').pick_venv() <cr>", desc = "Pick Venv" },
  },
}
