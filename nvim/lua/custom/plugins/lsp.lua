return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset {}
    end,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-buffer', -- Required
        'hrsh7th/cmp-path', -- Required
        'hrsh7th/cmp-nvim-lsp', -- Required
      },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

      require('lsp-zero.cmp').extend()

      -- And you can configure cmp even more, if you want to.
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local luasnip = require 'luasnip'

      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = lspkind.cmp_format {
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {
        'williamboman/mason-lspconfig.nvim',
        setup = function()
          require('mason').setup()
          require('mason-lspconfig').setup {
            ensure_installed = {
              'lua_ls',
              'cssls',
              'html',
              'pyright',
              'ruff_lsp',
            },
          }
        end,
      },
      { 'jose-elias-alvarez/typescript.nvim' },
      { 'VonHeikemen/lsp-zero.nvim' },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require 'lsp-zero'

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps { buffer = bufnr }
      end)

      lsp.skip_server_setup { 'tsserver' }

      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      require('typescript').setup {
        server = {
          on_attach = function(client, bufnr)
            -- You can find more commands in the documentation:
            -- https://github.com/jose-elias-alvarez/typescript.nvim#commands

            vim.keymap.set('n', '<leader>ci', '<cmd>TypescriptAddMissingImports<cr>', { buffer = bufnr })
          end,
        },
      }
    end,
  },
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v2.x',
  --   lazy = true,
  --   config = function()
  --     -- This is where you modify the settings for lsp-zero
  --     -- Note: autocompletion settings will not take effect
  --
  --     require('lsp-zero.settings').preset {}
  --   end,
  -- },
  --
  -- -- Autocompletion
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     { 'L3MON4D3/LuaSnip' },
  --   },
  --   config = function()
  --     -- Here is where you configure the autocompletion settings.
  --     -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
  --     -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
  --
  --     require('lsp-zero.cmp').extend()
  --
  --     -- And you can configure cmp even more, if you want to.
  --     local cmp = require 'cmp'
  --     local cmp_action = require('lsp-zero.cmp').action()
  --
  --     cmp.setup {
  --       mapping = {
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-f>'] = cmp_action.luasnip_jump_forward(),
  --         ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  --       },
  --     }
  --   end,
  -- },
  --
  -- -- LSP
  -- {
  --   'neovim/nvim-lspconfig',
  --   cmd = 'LspInfo',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   dependencies = {
  --     { 'hrsh7th/cmp-nvim-lsp' },
  --     { 'williamboman/mason-lspconfig.nvim' },
  --     { 'jose-elias-alvarez/typescript.nvim' },
  --     {
  --       'williamboman/mason.nvim',
  --       build = function()
  --         pcall(vim.cmd, 'MasonUpdate')
  --       end,
  --     },
  --   },
  --   config = function()
  --     -- This is where all the LSP shenanigans will live
  --
  --     local lsp = require 'lsp-zero'
  --
  --     lsp.on_attach(function(client, bufnr)
  --       lsp.default_keymaps { buffer = bufnr }
  --     end)
  --
  --     lsp.skip_server_setup { 'tsserver' }
  --
  --     -- (Optional) Configure lua language server for neovim
  --     require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
  --
  --     lsp.setup()
  --
  --     require('typescript').setup {
  --       server = {
  --         on_attach = function(client, bufnr)
  --           -- You can find more commands in the documentation:
  --           -- https://github.com/jose-elias-alvarez/typescript.nvim#commands
  --
  --           vim.keymap.set('n', '<leader>ci', '<cmd>TypescriptAddMissingImports<cr>', { buffer = bufnr })
  --         end,
  --       },
  --     }
  --   end,
  -- },
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',

    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    event = 'VeryLazy',
  },
  {
    'onsails/lspkind.nvim',
    event = 'VeryLazy',
  },
}
