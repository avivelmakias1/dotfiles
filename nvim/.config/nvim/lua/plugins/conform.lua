return function()
  local util = require 'config.util'
  local conform_util = require 'conform.util'

  local function js_cwd(self, ctx)
    return util.js_root(ctx.filename)
  end

  local function project_command(bin)
    return function(_, ctx)
      local root = util.js_root(ctx)
      local local_bin = util.find_upward(root, 'node_modules/.bin/' .. bin)
      return local_bin or util.executable(bin) or bin
    end
  end

  require('conform').setup {
    notify_on_error = true,
    notify_no_formatters = false,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      javascriptreact = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      ['javascript.jsx'] = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      typescript = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      typescriptreact = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      ['typescript.tsx'] = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      vue = { 'biome', 'prettierd', 'prettier', 'eslint_d', stop_after_first = true },
      css = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
    },
    formatters = {
      biome = {
        command = project_command 'biome',
        cwd = js_cwd,
        require_cwd = true,
      },
      prettier = {
        command = project_command 'prettier',
        cwd = js_cwd,
        require_cwd = true,
      },
      prettierd = {
        command = project_command 'prettierd',
        cwd = js_cwd,
        require_cwd = true,
      },
      eslint_d = {
        command = project_command 'eslint_d',
        cwd = js_cwd,
        require_cwd = true,
      },
      stylua = {
        command = conform_util.find_executable({ 'stylua' }, 'stylua'),
      },
    },
  }
end
