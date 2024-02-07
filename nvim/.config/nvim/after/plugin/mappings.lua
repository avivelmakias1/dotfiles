-- vim.keymap.set('n', ';', ':')

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

vim.keymap.set('n', 'ha', '<cmd>lua require("harpoon.mark").add_file()<cr>', { desc = 'Add mark'})
vim.keymap.set('n', 'hv', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { desc = 'Show all marks'})
vim.keymap.set('n', 'hd', '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { desc = 'Show all marks'})
vim.keymap.set('n', 'hf', '<cmd>lua require("harpoon.ui").nav_next()<cr>', { desc = 'Show all marks'})


vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- Workspaces
-- vim.keymap.set('n', '<leader>wa', '<cmd>WorkspacesAdd<cr>', { desc = 'Add Workspace' })
-- vim.keymap.set('n', '<leader>wr', '<cmd>WorkspacesRemove<cr>', { desc = 'Remove Current Workspace' })

-- Buffers
-- vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle pin' })
-- vim.keymap.set('n', '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', { desc = 'Delete non-pinned buffers' })
-- vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer to the left' })
-- vim.keymap.set('n', '<leader>bh', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer to the right' })
-- vim.keymap.set('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
-- vim.keymap.set('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
-- vim.keymap.set('n', '<C-b>', '<cmd>Bdelete<cr>', { desc = 'Close Buffer' })
-- vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<cr>', { desc = 'Close Buffer' })
-- vim.keymap.set('n', '<leader>h', '<cmd>BufferLinePick<cr>', { desc = 'Pick Buffer' })

-- UI Related
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Treefile' })
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>tb', '<cmd>BlamerToggle<cr>', { desc = 'Git blame' })

vim.keymap.set('n', '<leader>cr', '<cmd>OverseerRun<cr>', { desc = 'Run Overseer' })
vim.keymap.set('n', '<leader>to', '<cmd>OverseerToggle<cr>', { desc = 'Overseer Output' })

vim.keymap.set('n', '<leader>zm', '<cmd>ZenMode<cr>', { desc = 'Zen Mode' })

-- -- lua fzf
-- vim.keymap.set('n', '<leader>ff', '<cmd>lua require("fzf-lua").files()<cr>', { desc = 'Find Files (root dir)' })
-- vim.keymap.set('n', '<leader><leader>', '<cmd>lua require("fzf-lua").files()<cr>', { desc = 'Find Files (root dir)' })
-- vim.keymap.set('n', '<leader>fg', '<cmd>lua require("fzf-lua").live_grep()<cr>', { desc = 'Grep (root dir)' })
-- vim.keymap.set('n', '<leader>fb', '<cmd>lua require("fzf-lua").buffers()<cr>', { desc = 'Buffers' })
-- vim.keymap.set('n', '<leader>fh', '<cmd>lua require("fzf-lua").help_tags()<cr>', { desc = 'Help Pages' })
-- vim.keymap.set('n', '<leader>fm', '<cmd>lua require("fzf-lua").marks()<cr>', { desc = 'Jump to Mark' })
-- vim.keymap.set('n', '<leader>fr', '<cmd>lua require("fzf-lua").resume()<cr>', { desc = 'Resume' })
-- vim.keymap.set('n', '<leader>fo', '<cmd>lua require("fzf-lua").oldfiles()<cr>', { desc = 'Old Files' })
-- vim.keymap.set('n', '<leader>fw', '<cmd>lua require("fzf-lua").grep_cword()<cr>', { desc = 'Word (root dir)' })
-- vim.keymap.set('n', '<leader>fs', '<cmd>lua require("fzf-lua").grep_curbuf()<cr>', { desc = 'Search current buffer' })
-- vim.keymap.set('n', '<leader>fc', '<cmd>lua require("fzf-lua").commands()<cr>', { desc = 'Commands' })
-- vim.keymap.set('n', '<leader>fa', '<cmd>lua require("fzf-lua").autocommands()<cr>', { desc = 'Auto Commands' })
-- vim.keymap.set('n', '<leader>fk', '<cmd>lua require("fzf-lua").keymaps()<cr>', { desc = 'Key Maps' })
-- vim.keymap.set('v', '<leader>fw', '<cmd>lua require("fzf-lua").grep_visual()<cr>', { desc = 'Word (root dir)' })

-- Diagnostics
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

vim.keymap.set('n', '<leader>qa', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Format Related
vim.keymap.set('n', '<leader>lf', function()
  vim.cmd [[Format]]
end, { desc = 'Format' })

vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'LSP Definition' })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'LSP Implementation' })
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'LSP References' })
vim.keymap.set('n', 'gtd', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'LSP Type Definition' })
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'LSP Rename' })
vim.keymap.set('n', '<leader>ca', '<cmd>CodeActionMenu<cr>', { desc = 'Code Actions' })

-- Git Related
-- vim.keymap.set('n', '<leader>gi', '<cmd>Gitignore<cr>', { desc = 'Generate gitignore' })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = 'Git blame' })
vim.keymap.set('n', '<leader>gds', '<cmd>Gvdiffsplit!<cr>', { desc = 'Git Diff Split' })
vim.keymap.set('n', '<leader>gdh', '<cmd>diffget //2<cr>', { desc = 'Git Diff Get Left' })
vim.keymap.set('n', '<leader>gdl', '<cmd>diffget //3<cr>', { desc = 'Git Diff Get Right' })
vim.keymap.set('n', '<leader>gdc', '<cmd>only<cr>', { desc = 'Git Diff Close' })

-- vim.keymap.set('n', '<leader>/', 'gcc', { desc = "Comment Line"})
-- vim.keymap.set('v', '<leader>/', 'gc', { desc = "Comment Line"})
