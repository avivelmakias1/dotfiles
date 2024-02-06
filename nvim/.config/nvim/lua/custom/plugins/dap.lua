return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        opts = function(_, opts)
          opts.controls = {
            element = 'console',
            enabled = true,
            icons = {
              pause = '',
              play = '',
              run_last = '',
              step_back = '',
              step_into = '',
              step_out = '',
              step_over = '',
              terminate = '',
            },
          }
          opts.element_mappings = {}
          opts.expand_lines = true
          opts.floating = {
            border = 'single',
            mappings = {
              close = { 'q', '<Esc>' },
            },
          }
          opts.force_buffers = true
          opts.icons = {
            collapsed = '',
            current_frame = '',
            expanded = '',
          }
          opts.layouts = {
            {
              elements = {
                {
                  id = 'scopes',
                  size = 0.25,
                },
                {
                  id = 'breakpoints',
                  size = 0.25,
                },
                {
                  id = 'stacks',
                  size = 0.25,
                },
                {
                  id = 'watches',
                  size = 0.25,
                },
              },
              position = 'right',
              size = 40,
            },
            {
              elements = {
                {
                  id = 'repl',
                  size = 0.5,
                },
                {
                  id = 'console',
                  size = 0.5,
                },
              },
              position = 'bottom',
              size = 10,
            },
          }
          opts.mappings = {
            edit = 'e',
            expand = { '<CR>', '<2-LeftMouse>' },
            open = 'o',
            remove = 'd',
            repl = 'r',
            toggle = 't',
          }
          opts.render = {
            indent = 1,
            max_value_lines = 100,
          }
        end,
        keys = {
          { '<leader>tu', ":lua require('dapui').toggle() <cr>", desc = 'Toggle DAP UI' },
        },
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = true,
      },
      {
        'mfussenegger/nvim-dap-python',
      },
      {
        'mxsdev/nvim-dap-vscode-js',
      },
      {
        'microsoft/vscode-js-debug',
        version = '1.x',
        build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
      },
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })
      -- dap.defaults.fallback.terminal_win_cmd = 'enew'
      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = 'dap-repl',
      --   callback = function()
      --     require('dap.ext.autocompl').attach()
      --   end,
      -- })
      require('which-key').register {
        ['<leader>db'] = { name = '+breakpoints' },
        ['<leader>ds'] = { name = '+steps' },
        ['<leader>dv'] = { name = '+views' },
      }

      -- Setup dap for javascript
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }

      for _, language in ipairs { 'typescript', 'javascript', 'svelte' } do
        dap.configurations[language] = {
          -- attach to a node process that has been started with
          -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
          -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = 'pwa-node',
            -- attach to an already running node process with --inspect flag
            -- default port: 9222
            request = 'attach',
            -- allows us to pick the process using a picker
            processId = require('dap.utils').pick_process,
            -- name of the debug action you have to select for this config
            name = 'Attach debugger to existing `node --inspect` process',
            -- for compiled languages like TypeScript or Svelte.js
            sourceMaps = true,
            -- resolve source maps in nested locations while ignoring node_modules
            resolveSourceMapLocations = {
              '${workspaceFolder}/**',
              '!**/node_modules/**',
            },
            -- path to src in vite based projects (and most other projects as well)
            cwd = '${workspaceFolder}/src',
            -- we don't want to debug code inside node_modules, so skip it!
            skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
          },
          {
            type = 'pwa-chrome',
            name = 'Launch Chrome to debug client',
            request = 'launch',
            url = 'http://localhost:5173',
            sourceMaps = true,
            protocol = 'inspector',
            port = 9222,
            webRoot = '${workspaceFolder}/src',
            -- skip files from vite's hmr
            skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
          },
          -- only if language is javascript, offer this debug action
          language == 'javascript'
              and {
                -- use nvim-dap-vscode-js's pwa-node debug adapter
                type = 'pwa-node',
                -- launch a new process to attach the debugger to
                request = 'launch',
                -- name of the debug action you have to select for this config
                name = 'Launch file in new node process',
                -- launch current file
                program = '${file}',
                cwd = '${workspaceFolder}',
              }
            or nil,
        }
      end

      -- Setup dap for python
      local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
      pcall(function()
        require('dap-python').setup(mason_path .. 'packages/debugpy/venv/bin/python')
      end)

      -- Supported test frameworks are unittest, pytest and django. By default it
      -- tries to detect the runner by probing for pytest.ini and manage.py, if
      -- neither are present it defaults to unittest.
      pcall(function()
        require('dap-python').test_runner = 'pytest'
      end)

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
    keys = {
      {
        '<leader>dbc',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'conditional breakpoint',
      },
      {
        '<leader>dbl',
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message')
        end,
        desc = 'logpoint',
      },
      {
        '<leader>dbr',
        function()
          require('dap.breakpoints').clear()
        end,
        desc = 'remove all',
      },
      { '<leader>dbs', '<CMD>Telescope dap list_breakpoints<CR>', desc = 'show all' },
      {
        '<leader>dbt',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'toggle breakpoint',
      },
      {
        '<leader>dr',
        function()
          require('dap.ext.vscode').load_launchjs()
          require('dap').continue()
        end,
        desc = 'run',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'continue',
      },
      {
        '<leader>de',
        function()
          require('dap.ui.widgets').hover(nil, { border = 'none' })
        end,
        desc = 'expression',
        mode = { 'n', 'v' },
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'pause',
      },
      {
        '<leader>dsb',
        function()
          require('dap').step_back()
        end,
        desc = 'step back',
      },
      {
        '<leader>dsc',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'step to cursor',
      },
      {
        '<leader>dsi',
        function()
          require('dap').step_into()
        end,
        desc = 'step into',
      },
      {
        '<leader>dso',
        function()
          require('dap').step_over()
        end,
        desc = 'step over',
      },
      {
        '<leader>dsx',
        function()
          require('dap').step_out()
        end,
        desc = 'step out',
      },
      {
        '<leader>dx',
        function()
          require('dap').terminate()
        end,
        desc = 'terminate',
      },
      {
        '<leader>dvf',
        function()
          require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames, { border = 'none' })
        end,
        desc = 'show frames',
      },
      {
        '<leader>dvr',
        function()
          require('dap').repl.open(nil, '20split')
        end,
        desc = 'show repl',
      },
      {
        '<leader>dvs',
        function()
          require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes, { border = 'none' })
        end,
        desc = 'show scopes',
      },
      {
        '<leader>dvt',
        function()
          require('dap.ui.widgets').centered_float(require('dap.ui.widgets').threads, { border = 'none' })
        end,
        desc = 'show threads',
      },
      {
        '<leader>dtm',
        function()
          require('dap-python').test_method()
        end,
        desc = 'test method',
      },
    },
  },
}
