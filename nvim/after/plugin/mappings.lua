vim.keymap.set('n', ';', ':')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true })

-- Movement
vim.keymap.set('n', '<C-h>', '<C-w>h') -- move left
vim.keymap.set('n', '<C-j>', '<C-w>j') -- move down
vim.keymap.set('n', '<C-k>', '<C-w>k') -- move up
vim.keymap.set('n', '<C-l>', '<C-w>l') -- move right

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- Workspaces
vim.keymap.set('n', '<leader>wa', '<cmd>WorkspacesAdd<cr>', { desc = 'Add Workspace' })
vim.keymap.set('n', '<leader>wr', '<cmd>WorkspacesRemove<cr>', { desc = 'Remove Current Workspace' })

-- Buffers
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle pin' })
vim.keymap.set('n', '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', { desc = 'Delete non-pinned buffers' })
vim.keymap.set('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<C-b>', '<cmd>Bdelete<cr>', { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<cr>', { desc = 'Close Buffer' })

-- UI Related
vim.keymap.set('n', '<leader>e', '<cmd>Neotree<cr>', { desc = 'Treefile' })
vim.keymap.set('n', '<leader>te', '<cmd>NeoTreeShowToggle<cr>', { desc = 'Treefile' })
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>tb', '<cmd>BlamerToggle<cr>', { desc = 'Git blame' })

vim.keymap.set('n', '<leader>cr', '<cmd>OverseerRun<cr>', { desc = 'Run Overseer' })
vim.keymap.set('n', '<leader>to', '<cmd>OverseerToggle<cr>', { desc = 'Overseer Output' })

-- Diagnostics
vim.keymap.set('n', '<leader>ca', '<cmd>CodeActionMenu<cr>', { desc = 'Code Actions' })
vim.keymap.set('n', '<leader>qq', '<cmd>TroubleToggle document_diagnostics<cr>', { desc = 'Trouble Document' })
vim.keymap.set('n', '<leader>qw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { desc = 'Trouble Workspace' })
vim.keymap.set('n', '<leader>ql', function()
  vim.diagnostic.config { virtual_text = not require('lsp_lines').toggle() }
end, {
  desc = 'multiple error lines',
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- LSP Related
vim.keymap.set('n', '<leader>lf', function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  }
end, { desc = 'LSP Format' })

vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'LSP Definition' })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'LSP Implementation' })
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'LSP References' })
vim.keymap.set('n', 'gtd', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'LSP Type Definition' })
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'LSP Rename' })

-- Git Related
vim.keymap.set('n', '<leader>gi', '<cmd>Gitignore<cr>', { desc = 'Generate gitignore' })

-- vim.keymap.set('n', '<leader>/', 'gcc', { desc = "Comment Line"})
-- vim.keymap.set('v', '<leader>/', 'gc', { desc = "Comment Line"})
