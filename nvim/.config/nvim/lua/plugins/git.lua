return function()
  require('gitsigns').setup {
    current_line_blame = false,
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local map = function(lhs, rhs, desc, mode)
        vim.keymap.set(mode or 'n', lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map(']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
          return
        end
        gitsigns.nav_hunk 'next'
      end, 'Next git hunk')

      map('[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
          return
        end
        gitsigns.nav_hunk 'prev'
      end, 'Previous git hunk')

      map('<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
      map('<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
      map('<leader>hp', gitsigns.preview_hunk, 'Preview hunk')
      map('<leader>hb', gitsigns.blame_line, 'Blame line')
    end,
  }
end
