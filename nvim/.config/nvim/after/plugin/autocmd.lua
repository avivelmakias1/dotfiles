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

-- vim.api.nvim_create_autocmd("VimEnter", {
--   desc = "Auto select virtualenv Nvim open",
--   pattern = "*",
--   callback = function()
--     local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
--     if venv ~= "" then
--       require("venv-selector").retrieve_from_cache()
--     end
--   end,
--   once = true,
-- })

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
  callback = function()
    local lint_status, lint = pcall(require, "lint")
    if lint_status then
      lint.try_lint()
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = augroup("auto_create_dir"),
--   callback = function(event)
--     if event.match:match("^%w%w+://") then
--       return
--     end
--     local file = vim.loop.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })
vim.api.nvim_create_augroup("py-fstring", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
    pattern = { "*.py" },
    group = "py-fstring",
    --- @param opts AutoCmdCallbackOpts
    --- @return nil
    callback = function(opts)
        -- Only run if f-string escape character is typed
        if vim.v.char ~= "{" then return end

        -- Get node and return early if not in a string
        local node = vim.treesitter.get_node()

        if not node then return end
        if node:type() ~= "string" then node = node:parent() end
        if not node or node:type() ~= "string" then return end

        vim.print(node:type())
        local row, col, _, _ = vim.treesitter.get_node_range(node)

        -- Return early if string is already a format string
        local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
        vim.print("row " .. row .. " col " .. col)
        vim.print("char: '" .. first_char .. "'")
        if first_char == "f" then return end

        -- Otherwise, make the string a format string
        vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
    end,
})

-- Jump to last accessed window on closing the current one
WinCloseJmp = function ()
  -- Exclude floating windows
  if '' ~= vim.api.nvim_win_get_config(0).relative then return end
  -- Record the window we jump from (previous) and to (current)
  if nil == vim.t.winid_rec then
    vim.t.winid_rec = { prev = vim.fn.win_getid(), current = vim.fn.win_getid() }
  else
    vim.t.winid_rec = { prev = vim.t.winid_rec.current, current = vim.fn.win_getid() }
  end

  -- Loop through all windows to check if the previous one has been closed
  for winnr=1,vim.fn.winnr('$') do
    if vim.fn.win_getid(winnr) == vim.t.winid_rec.prev then
      return        -- Return if previous window is not closed
    end
  end

  vim.cmd [[ wincmd p ]]
end

vim.cmd [[ autocmd VimEnter,WinEnter * lua WinCloseJmp() ]]


-- delete [no name] buffer
vim.api.nvim_create_autocmd("BufHidden", {
  desc = "Delete [No Name] buffers",
  callback = function(event)
    if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
      vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
    end
  end,
})
