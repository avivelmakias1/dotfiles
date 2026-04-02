local M = {}

local plugins = {
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  'https://github.com/folke/snacks.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
}

local function modules_ready()
  local required = {
    'catppuccin',
    'snacks',
    'nvim-treesitter.config',
    'blink.cmp',
    'which-key',
    'gitsigns',
    'conform',
    'mason',
    'dap',
    'nio',
    'dapui',
  }

  for _, module in ipairs(required) do
    if not pcall(require, module) then
      return false
    end
  end

  return true
end

function M.setup()
  vim.pack.add(plugins, {
    confirm = false,
    load = function(plugin)
      vim.cmd.packadd(plugin.spec.name)
    end,
  })

  if not modules_ready() then
    vim.schedule(function()
      vim.notify('Plugins were installed with vim.pack. Restart Neovim to finish loading the new config.', vim.log.levels.WARN, {
        title = 'vim.pack bootstrap',
      })
    end)

    return false
  end

  require 'plugins.mason'()
  require 'plugins.colorscheme'()
  require 'plugins.snacks'()
  require 'plugins.treesitter'()
  require 'plugins.blink'()
  require 'plugins.copilot'()
  require 'plugins.whichkey'()
  require 'plugins.git'()
  require 'plugins.conform'()
  require 'plugins.dap'()

  return true
end

return M
