local util = require 'config.util'
local unpack_fn = unpack or table.unpack

local function find_ts_client(bufnr)
  local function current()
    local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'vtsls' }
    if #clients > 0 then
      return clients[1]
    end

    clients = vim.lsp.get_clients { name = 'vtsls' }
    if #clients > 0 then
      return clients[1]
    end
  end

  local client = current()
  if client then
    return client
  end

  vim.wait(1000, function()
    client = current()
    return client ~= nil
  end, 50)

  return client
end

return {
  cmd = { util.executable 'vue-language-server' or 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    'pnpm-workspace.yaml',
    'nx.json',
    '.git',
  },
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local ts_client = find_ts_client(context.bufnr)
      if not ts_client then
        vim.notify('Could not find `vtsls` lsp client, vue types will be limited', vim.log.levels.WARN, { title = 'vue_ls' })
        return
      end

      local id, command, payload = unpack_fn(result or {})

      ts_client:exec_cmd({
        title = 'vue_request_forward',
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        client:notify('tsserver/response', { { id, r and r.body } })
      end)
    end
  end,
}
