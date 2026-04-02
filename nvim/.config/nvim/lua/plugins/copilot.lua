return function()
  require('copilot').setup {
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      hide_during_completion = true,
      keymap = {
        accept = '<C-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    filetypes = {
      markdown = false,
      help = false,
    },
  }
end
