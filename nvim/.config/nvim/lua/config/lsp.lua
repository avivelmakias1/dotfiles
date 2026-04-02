local util = require 'config.util'

local function lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, blink = pcall(require, 'blink.cmp')
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

vim.diagnostic.config {
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 2,
    source = 'if_many',
  },
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.HINT] = 'H',
      [vim.diagnostic.severity.INFO] = 'I',
    },
  },
}

vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
  config = vim.tbl_deep_extend('force', config or {}, { border = 'rounded' })
  return vim.lsp.handlers.hover(err, result, ctx, config)
end

vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
  config = vim.tbl_deep_extend('force', config or {}, { border = 'rounded' })
  return vim.lsp.handlers.signature_help(err, result, ctx, config)
end

vim.lsp.config('*', {
  capabilities = lsp_capabilities(),
  root_markers = { '.git' },
})

vim.lsp.enable {
  'lua_ls',
  'ruff',
  'basedpyright',
  'vtsls',
  'vue_ls',
  'eslint',
}

local lsp_group = vim.api.nvim_create_augroup('config-lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    if client.name == 'vtsls' and vim.bo[event.buf].filetype == 'vue' and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider.full = false
    end

    if client.name == 'vue_ls' then
      client.server_capabilities.declarationProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.implementationProvider = false
      client.server_capabilities.typeDefinitionProvider = false
    end

    local map = function(lhs, rhs, desc, mode)
      vim.keymap.set(mode or 'n', lhs, rhs, { buffer = event.buf, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('gr', vim.lsp.buf.references, 'List references')
    map('gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('gt', vim.lsp.buf.type_definition, 'Go to type definition')
    map('K', vim.lsp.buf.hover, 'Hover documentation')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
    map('<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
    map('<leader>cs', vim.lsp.buf.signature_help, 'Signature help')
    map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
    map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
    map('<leader>wl', function()
      vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO, { title = 'Workspace Folders' })
    end, 'List workspace folders')
    map('<leader>ci', function()
      local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
    end, 'Toggle inlay hints')

    if client:supports_method('textDocument/inlayHint', event.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    if client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_group = vim.api.nvim_create_augroup('config-lsp-highlight-' .. event.buf, { clear = true })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = highlight_group,
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'LspDetach' }, {
        group = highlight_group,
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client:supports_method('textDocument/linkedEditingRange', event.buf) then
      vim.lsp.linked_editing_range.enable(true, { bufnr = event.buf })
    end

    vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end,
})

vim.api.nvim_create_user_command('LspRoot', function()
  vim.notify(util.project_root(0), vim.log.levels.INFO, { title = 'LSP Root' })
end, {})
