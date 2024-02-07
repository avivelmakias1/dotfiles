return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = '*', -- telescope did only one release, so use HEAD for now
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
    },
    keys = {
      { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
      { '<leader><space>', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Find Files (root dir)' },
      -- find
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files (root dir)' },
      { '<leader>fR', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
      -- git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'status' },
      -- search
      { '<leader>fa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
      { '<leader>fib', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
      { '<leader>fC', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>fc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
      { '<leader>fg', "<cmd>:lua require('telescope.builtin').live_grep()<cr>", desc = 'Grep (root dir)' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
      { '<leader>fH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
      { '<leader>fm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
      { '<leader>fo', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
      { '<leader>fr', '<cmd>Telescope resume<cr>', desc = 'Resume' },
      { '<leader>fw', "<cmd>:lua require('telescope.builtin').grep_string()<cr>", desc = 'Word (root dir)' },
      { '<leader>fw', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', mode = 'v' },
      -- workspaces
      -- { '<leader>wl', '<cmd>Telescope workspaces<cr>', desc = 'Projects' },
    },
    config = function()
      local telescope = require 'telescope'
      telescope.setup {
        defaults = {
          path_display = { 'truncate' },
          prompt_prefix = ' ',
          selection_caret = ' ',
          mappings = {
            i = {
              ['<c-t>'] = function(...)
                return require('trouble.providers.telescope').open_with_trouble(...)
              end,
              ['<a-t>'] = function(...)
                return require('trouble.providers.telescope').open_selected_with_trouble(...)
              end,
              ['<C-Down>'] = function(...)
                return require('telescope.actions').cycle_history_next(...)
              end,
              ['<C-Up>'] = function(...)
                return require('telescope.actions').cycle_history_prev(...)
              end,
              ['<C-f>'] = function(...)
                return require('telescope.actions').preview_scrolling_down(...)
              end,
              ['<C-b>'] = function(...)
                return require('telescope.actions').preview_scrolling_up(...)
              end,
            },
            n = {
              ['q'] = function(...)
                return require('telescope.actions').close(...)
              end,
            },
          },
          file_ignore_patterns = {
            'node_modules',
            '.git',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }
      telescope.load_extension 'fzf'
    end,
  },
}
