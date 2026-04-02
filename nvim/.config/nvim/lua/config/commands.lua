local util = require 'config.util'

vim.api.nvim_create_user_command('ConfigRoot', function()
  vim.notify(util.project_root(0), vim.log.levels.INFO, { title = 'Project Root' })
end, {})

vim.api.nvim_create_user_command('ConfigLsp', function()
  local names = vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.get_clients { bufnr = 0 })

  vim.notify(next(names) and table.concat(names, ', ') or 'No LSP clients attached', vim.log.levels.INFO, { title = 'LSP Clients' })
end, {})

vim.api.nvim_create_user_command('ConfigFormat', function()
  local ok = pcall(vim.cmd, 'ConformInfo')
  if not ok then
    vim.notify('Conform is not available yet', vim.log.levels.WARN, { title = 'Formatting' })
  end
end, {})

vim.api.nvim_create_user_command('ConfigDap', function()
  local ok, dap = pcall(require, 'dap')
  if not ok then
    vim.notify('nvim-dap is not available yet', vim.log.levels.WARN, { title = 'DAP' })
    return
  end

  vim.notify(vim.inspect(dap.configurations[vim.bo.filetype] or {}), vim.log.levels.INFO, { title = 'DAP Configurations' })
end, {})
