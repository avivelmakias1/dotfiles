return {
  'Exafunction/codeium.vim',
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<M-a>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true })
    vim.keymap.set('i', '<M-m>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true })
    vim.keymap.set('i', '<M-n>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true })
    vim.keymap.set('i', '<M-c>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true })
    vim.keymap.set('n', '<M-d>', '<cmd>Codeium Disable<cr>', { desc = 'Disable Codeium' })
    vim.keymap.set('n', '<M-e>', '<cmd>Codeium Enable<cr>', { desc = 'Enable Codeium' })
  end,
}
