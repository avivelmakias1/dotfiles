return function()
  local dap = require 'dap'
  local dapui = require 'dapui'
  local util = require 'config.util'

  local debugpy = util.executable 'debugpy-adapter' or 'debugpy-adapter'
  local js_debug = util.executable 'js-debug-adapter' or 'js-debug-adapter'

  for type, icon in pairs {
    DapBreakpoint = 'B',
    DapBreakpointCondition = 'C',
    DapLogPoint = 'L',
    DapStopped = '>',
  } do
    vim.fn.sign_define(type, { text = icon, texthl = type, linehl = '', numhl = '' })
  end

  dapui.setup {
    controls = {
      enabled = true,
    },
    floating = {
      border = 'rounded',
    },
    layouts = {
      {
        elements = {
          { id = 'scopes', size = 0.5 },
          { id = 'breakpoints', size = 0.2 },
          { id = 'stacks', size = 0.15 },
          { id = 'watches', size = 0.15 },
        },
        position = 'right',
        size = 44,
      },
      {
        elements = {
          { id = 'repl', size = 0.4 },
          { id = 'console', size = 0.6 },
        },
        position = 'bottom',
        size = 12,
      },
    },
  }

  dap.listeners.after.event_initialized['config-dapui'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['config-dapui'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['config-dapui'] = function()
    dapui.close()
  end

  dap.adapters.python = {
    type = 'executable',
    command = debugpy,
  }

  dap.adapters['pwa-node'] = {
    type = 'server',
    host = '127.0.0.1',
    port = '${port}',
    executable = {
      command = js_debug,
      args = { '${port}' },
    },
  }

  dap.adapters['pwa-chrome'] = {
    type = 'server',
    host = '127.0.0.1',
    port = '${port}',
    executable = {
      command = js_debug,
      args = { '${port}' },
    },
  }

  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = 'Launch current file',
      program = '${file}',
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      justMyCode = false,
    },
    {
      type = 'python',
      request = 'launch',
      name = 'Pytest current file',
      module = 'pytest',
      args = { '${file}' },
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      justMyCode = false,
    },
  }

  local js_configurations = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch current file',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process',
      cwd = '${workspaceFolder}',
      processId = require('dap.utils').pick_process,
      sourceMaps = true,
    },
    {
      type = 'pwa-chrome',
      request = 'launch',
      name = 'Launch Chrome against localhost:3000',
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      sourceMaps = true,
    },
  }

  for _, filetype in ipairs { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' } do
    dap.configurations[filetype] = js_configurations
  end
end
