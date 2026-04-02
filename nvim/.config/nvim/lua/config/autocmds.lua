local format = require 'config.format'

local augroup = vim.api.nvim_create_augroup('config', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  callback = function(args)
    if vim.g.autoformat then
      format.format_on_save(args.buf)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'qf',
  callback = function(args)
    local quickfix = require 'config.quickfix'

    local map_move = function(lhs, delta)
      vim.keymap.set('n', lhs, function()
        quickfix.move(delta)
      end, { buffer = args.buf, silent = true })
    end

    map_move('j', 1)
    map_move('k', -1)
    map_move('<Down>', 1)
    map_move('<Up>', -1)
    map_move('<C-n>', 1)
    map_move('<C-p>', -1)

    local function follow()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_get_current_buf() == args.buf then
          quickfix.follow()
        end
      end)
    end

    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorMoved' }, {
      group = augroup,
      buffer = args.buf,
      callback = follow,
    })

    follow()
  end,
})
