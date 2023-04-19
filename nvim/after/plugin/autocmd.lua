-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd("VimEnter", {
desc = "Auto select virtualenv Nvim open",
pattern = "*",
callback = function()
  local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
  if venv ~= "" then
    require("venv-selector").retrieve_from_cache()
  end
end,
once = true,
})
