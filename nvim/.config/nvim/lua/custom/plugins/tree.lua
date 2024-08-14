return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        sort_by = 'case_sensitive',
        renderer = {
          group_empty = true,
        },
        update_focused_file = {
          enable = true,
        },
      }
    end,
  },
}
