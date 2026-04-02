local M = {}

local js_like = {
  javascript = true,
  javascriptreact = true,
  ['javascript.jsx'] = true,
  typescript = true,
  typescriptreact = true,
  ['typescript.tsx'] = true,
  vue = true,
}

local source_actions = {
  python = {
    { client = 'ruff', kind = 'source.fixAll.ruff' },
    { client = 'ruff', kind = 'source.organizeImports.ruff' },
  },
  javascript = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
  javascriptreact = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
  ['javascript.jsx'] = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
  typescript = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
  typescriptreact = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
  ['typescript.tsx'] = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
  vue = {
    { client = 'eslint', kind = 'source.fixAll.eslint' },
    { client = 'vtsls', kind = 'source.organizeImports' },
  },
}

local function full_document_range(bufnr)
  local last_line = vim.api.nvim_buf_line_count(bufnr)
  local last_text = vim.api.nvim_buf_get_lines(bufnr, math.max(last_line - 1, 0), last_line, false)[1] or ''
  local last_col = #last_text

  return {
    start = { line = 0, character = 0 },
    ['end'] = { line = math.max(last_line - 1, 0), character = last_col },
  }
end

local function action_diagnostics(bufnr, client)
  local diagnostics = {}
  local namespace = vim.lsp.diagnostic.get_namespace(client.id)

  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr, { namespace = namespace })) do
    local lsp_diagnostic = diagnostic.user_data and diagnostic.user_data.lsp
    if lsp_diagnostic then
      diagnostics[#diagnostics + 1] = lsp_diagnostic
    end
  end

  return diagnostics
end

local function apply_workspace_edit(client, action)
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or 'utf-16')
  end
end

local function apply_command(client, bufnr, action)
  local command = action.command
  if command == nil then
    return
  end

  if type(command) == 'string' then
    command = {
      title = action.title or command,
      command = command,
      arguments = action.arguments,
    }
  end

  if type(command) ~= 'table' or type(command.command) ~= 'string' or command.command == '' then
    return
  end

  local ok = pcall(function()
    client:exec_cmd(command, { bufnr = bufnr }, function() end)
  end)
  if not ok then
    client:request_sync('workspace/executeCommand', command, 1000, bufnr)
  end
end

local function apply_source_action(bufnr, spec)
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = spec.client })[1]
  if not client or not client:supports_method('textDocument/codeAction', bufnr) then
    return
  end

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    range = full_document_range(bufnr),
    context = {
      only = { spec.kind },
      triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Automatic,
      diagnostics = action_diagnostics(bufnr, client),
    },
  }

  local response = client:request_sync('textDocument/codeAction', params, 1500, bufnr)
  local actions = response and response.result or {}
  for _, action in ipairs(actions) do
    apply_workspace_edit(client, action)
    apply_command(client, bufnr, action)
  end
end

local function apply_source_actions(bufnr)
  local filetype = vim.bo[bufnr].filetype
  for _, spec in ipairs(source_actions[filetype] or {}) do
    apply_source_action(bufnr, spec)
  end
end

local function lsp_format(bufnr)
  local filetype = vim.bo[bufnr].filetype
  if filetype == 'python' then
    vim.lsp.buf.format {
      bufnr = bufnr,
      async = false,
      timeout_ms = 2000,
      name = 'ruff',
    }
    return
  end

  vim.lsp.buf.format {
    bufnr = bufnr,
    async = false,
    timeout_ms = 2000,
    filter = function(client)
      return client.name ~= 'eslint'
    end,
  }
end

function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  if vim.bo[bufnr].buftype ~= '' then
    return
  end

  apply_source_actions(bufnr)

  if filetype == 'python' then
    lsp_format(bufnr)
    return
  end

  local ok, conform = pcall(require, 'conform')
  if ok and (js_like[filetype] or filetype == 'lua' or filetype == 'json' or filetype == 'html' or filetype == 'css' or filetype == 'markdown') then
    conform.format {
      bufnr = bufnr,
      async = false,
      timeout_ms = 2000,
      lsp_format = 'fallback',
      quiet = true,
    }
    return
  end

  lsp_format(bufnr)
end

function M.format_on_save(bufnr)
  if vim.b[bufnr].format_running then
    return
  end

  if vim.bo[bufnr].buftype ~= '' or not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
    return
  end

  vim.b[bufnr].format_running = true
  local ok, err = pcall(M.format)
  vim.b[bufnr].format_running = false

  if not ok then
    vim.notify(err, vim.log.levels.ERROR, { title = 'Format on Save' })
  end
end

return M
