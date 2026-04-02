local M = {}

local function is_qf_win(winid)
  if not winid or winid == 0 or not vim.api.nvim_win_is_valid(winid) then
    return false
  end

  local buf = vim.api.nvim_win_get_buf(winid)
  return vim.bo[buf].buftype == 'quickfix'
end

local function target_win(qf_winid)
  local alt = vim.fn.win_getid(vim.fn.winnr '#')
  if alt ~= qf_winid and is_qf_win(alt) == false then
    return alt
  end

  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if winid ~= qf_winid and is_qf_win(winid) == false then
      return winid
    end
  end
end

local function current_entry(qf_winid)
  local info = vim.fn.getwininfo(qf_winid)[1]
  if not info or info.loclist == 1 then
    return
  end

  local idx = vim.api.nvim_win_get_cursor(qf_winid)[1]
  local items = vim.fn.getqflist({ items = 0 }).items or {}
  return items[idx]
end

local function entry_key(entry)
  return table.concat({
    entry.bufnr or 0,
    entry.filename or '',
    entry.lnum or 0,
    entry.col or 0,
  }, ':')
end

local function open_entry(winid, entry)
  if not winid or not entry then
    return
  end

  local bufnr = entry.bufnr
  if (not bufnr or bufnr == 0 or not vim.api.nvim_buf_is_valid(bufnr)) and entry.filename and entry.filename ~= '' then
    bufnr = vim.fn.bufadd(entry.filename)
    vim.fn.bufload(bufnr)
  end

  if not bufnr or bufnr == 0 or not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local ok = pcall(vim.api.nvim_win_set_buf, winid, bufnr)
  if not ok then
    return
  end

  local lnum = math.max(entry.lnum or 1, 1)
  local last_line = math.max(vim.api.nvim_buf_line_count(bufnr), 1)
  local col = math.max((entry.col or 1) - 1, 0)

  vim.api.nvim_win_set_cursor(winid, { math.min(lnum, last_line), col })
  vim.api.nvim_win_call(winid, function()
    vim.cmd 'normal! zvzz'
  end)
end

function M.follow()
  local qf_winid = vim.api.nvim_get_current_win()
  local qf_bufnr = vim.api.nvim_get_current_buf()

  if is_qf_win(qf_winid) == false then
    return
  end

  local entry = current_entry(qf_winid)
  if not entry then
    return
  end

  local key = entry_key(entry)
  if vim.b[qf_bufnr].qf_follow_key == key then
    return
  end
  vim.b[qf_bufnr].qf_follow_key = key

  open_entry(target_win(qf_winid), entry)
end

function M.move(delta)
  local winid = vim.api.nvim_get_current_win()
  if is_qf_win(winid) == false then
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(winid)
  local target = cursor[1] + (delta * vim.v.count1)
  local last_line = vim.api.nvim_buf_line_count(0)
  target = math.min(math.max(target, 1), last_line)

  if target == cursor[1] then
    return
  end

  vim.api.nvim_win_set_cursor(winid, { target, cursor[2] })
  M.follow()
end

return M
