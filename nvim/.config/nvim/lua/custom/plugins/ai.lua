return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    opts = {
      show_help = 'yes', -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
    },
    build = function()
      vim.notify "Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim."
    end,
    event = 'VeryLazy',
    keys = {
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      {
        '<leader>ccv',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>ccx',
        ':CopilotChatInPlace<cr>',
        mode = 'x',
        desc = 'CopilotChat - Run in-place code',
      },
      {
        '<leader>ccf',
        '<cmd>CopilotChatFixDiagnostic<cr>', -- Get a fix for the diagnostic message under the cursor.
        desc = 'CopilotChat - Fix diagnostic',
      },
      {
        '<leader>ccr',
        '<cmd>CopilotChatReset<cr>', -- Reset chat history and clear buffer.
        desc = 'CopilotChat - Reset chat history and clear buffer',
      },
    },
  },
  -- {
  --   'Exafunction/codeium.vim',
  --   config = function()
  --     vim.g.codeium_no_map_tab = 1
  --     vim.keymap.set('i', '<M-l>', function()
  --       return vim.fn['codeium#Accept']()
  --     end, { expr = true })
  --   end,
  -- },
}
