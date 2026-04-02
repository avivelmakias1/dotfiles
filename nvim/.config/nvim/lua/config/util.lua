local M = {}

local path_sep = package.config:sub(1, 1)

local function normalize(path)
  return path and vim.fs.normalize(path) or nil
end

function M.join(...)
  return table.concat({ ... }, path_sep)
end

function M.exists(path)
  return path ~= nil and vim.uv.fs_stat(path) ~= nil
end

function M.is_dir(path)
  local stat = path and vim.uv.fs_stat(path) or nil
  return stat ~= nil and stat.type == 'directory'
end

function M.buf_path(bufnr)
  if type(bufnr) == 'table' then
    if type(bufnr.filename) == 'string' and bufnr.filename ~= '' then
      return normalize(bufnr.filename)
    end
    if type(bufnr.bufnr) == 'number' then
      return M.buf_path(bufnr.bufnr)
    end
    if type(bufnr.buf) == 'number' then
      return M.buf_path(bufnr.buf)
    end
  end

  if type(bufnr) == 'string' then
    return normalize(bufnr)
  end

  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  if name == '' then
    return vim.uv.cwd()
  end
  return normalize(name)
end

function M.parents(path)
  local resolved = normalize(path or vim.uv.cwd())
  if resolved == nil then
    return { vim.uv.cwd() }
  end

  local stat = vim.uv.fs_stat(resolved)
  local start = stat and stat.type == 'directory' and resolved or vim.fs.dirname(resolved)
  local dirs = { start }
  for parent in vim.fs.parents(start) do
    table.insert(dirs, parent)
  end
  return dirs
end

function M.find_upward(path, relative)
  for _, dir in ipairs(M.parents(path)) do
    local candidate = M.join(dir, relative)
    if M.exists(candidate) then
      return candidate
    end
  end
end

function M.project_root(bufnr, markers)
  local start = M.buf_path(bufnr)
  if markers and #markers > 0 then
    local found = vim.fs.find(markers, { path = start, upward = true })[1]
    if found then
      return vim.fs.dirname(found)
    end
  end

  local git_dir = vim.fs.find('.git', { path = start, upward = true })[1]
  if git_dir then
    return vim.fs.dirname(git_dir)
  end

  return vim.uv.cwd()
end

function M.mason_bin(name)
  local candidate = normalize(vim.fn.stdpath 'data' .. '/mason/bin/' .. name)
  if M.exists(candidate) then
    return candidate
  end
end

function M.mason_package_path(name)
  local candidate = normalize(vim.fn.stdpath 'data' .. '/mason/packages/' .. name)
  if M.is_dir(candidate) then
    return candidate
  end
end

function M.executable(...)
  for _, name in ipairs { ... } do
    if name and name:find(path_sep, 1, true) and M.exists(name) then
      return name
    end

    if name and vim.fn.executable(name) == 1 then
      return vim.fn.exepath(name)
    end

    local mason = name and M.mason_bin(name) or nil
    if mason then
      return mason
    end
  end
end

function M.extend_path(root)
  local parts = {}
  local candidates = {
    'node_modules/.bin',
    '.venv/bin',
    'venv/bin',
  }

  if root and root ~= '' then
    for _, rel in ipairs(candidates) do
      local dir = M.join(root, rel)
      if M.is_dir(dir) then
        table.insert(parts, dir)
      end
    end
  end

  local mason_bin = normalize(vim.fn.stdpath 'data' .. '/mason/bin')
  if M.is_dir(mason_bin) then
    table.insert(parts, mason_bin)
  end

  table.insert(parts, vim.env.PATH or '')
  return table.concat(parts, ':')
end

function M.js_root(bufnr)
  return M.project_root(bufnr, {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    'pnpm-workspace.yaml',
    'nx.json',
    '.git',
  })
end

function M.python_root(bufnr)
  return M.project_root(bufnr, {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    'uv.lock',
    'requirements.txt',
    '.git',
  })
end

function M.find_typescript_lib(bufnr)
  local root = M.js_root(bufnr)
  return M.find_upward(root, 'node_modules/typescript/lib')
end

function M.vue_language_server_path()
  local mason_path = M.mason_package_path 'vue-language-server'
  if mason_path then
    local candidate = M.join(mason_path, 'node_modules/@vue/language-server')
    if M.is_dir(candidate) then
      return candidate
    end
  end
end

return M
