return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon').setup {
        global_settings = {
          mark_branch = true,
        },
      }
    end,
  },
  {
    'ggandor/leap.nvim',
    lazy = false,
    keys = {
      {"<cr>", "<Plug>(leap)", desc = "Leap"},
    },
  },
  {
    'gbprod/cutlass.nvim',
  },
  {
    'chrishrb/gx.nvim',
    event = { 'BufEnter' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    config = true, -- default settings
    keys = {
      { 'gx', '<cmd>Browse<cr>', desc = 'Open URL under cursor' },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
  -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
  },
}
