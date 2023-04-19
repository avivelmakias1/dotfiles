return {
  {
    'natecraddock/workspaces.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('workspaces').setup {
        hooks = {
          open = { 'Telescope find_files' },
        },
      }
      local telescope = require 'telescope'
      telescope.load_extension 'workspaces'
    end,
  },
}
