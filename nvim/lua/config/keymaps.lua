-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- map("n", "<S-w>", "<cmd>BufferKill<cr>", { desc = "Close Buffer" })
-- vim.keymap.set("n", "<S-w>", "<cmd><cr>", { desc = "Close Buffer" })
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

vim.keymap.set(
  "n",
  "<leader>ct",
  "<CMD>TermExec cmd='source $VIRTUAL_ENV/bin/activate'<CR>",
  { noremap = true, silent = true, desc = "Source Venv In Terminal" }
)
