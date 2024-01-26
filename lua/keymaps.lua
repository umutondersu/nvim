-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local map = vim.keymap.set
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>Q', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- jj for escaping insert mode
map('i', 'jj', '<Esc>', { silent = true })

-- Custom keymaps for turkish qwerty
map({ 'n', 'v' }, 'ş', '^', { silent = true }) -- move to first non-blank character
map('n', 'ç', '>', { silent = true })
map('n', 'ö', '<', { silent = true })
map({ 'n', 'v' }, 'ğ', '{', { silent = true })
map({ 'n', 'v' }, 'ü', '}', { silent = true })
map({ 'n', 'v' }, '+', '$', { silent = true }) -- move to end of line

-- New line without insert mode
map('n', '<M-o>', 'o<Esc>', { desc = 'New Line Down' })
map('n', '<M-O>', 'O<Esc>', { desc = 'New Line Up' })

-- Swap r and ctrl+r
map('n', '<C-r>', 'r', { silent = true }) -- replace a single character
map('n', 'r', '<C-r>', { silent = true }) -- redo

map('n', '<leader>i', function()
  require('lsp-inlayhints').toggle()
end, { desc = 'Toggle [I]nlay hints' })

-- Sync only puts and x cuts with system clipboard (smartyank required)
map({ 'n', 'v' }, 'p', '"+p', { silent = true })
map({ 'n', 'v' }, 'P', '"+P', { silent = true })
map({ 'n', 'v' }, 'x', '"+d', { silent = true })
map({ 'n', 'v' }, 'X', '"+D', { silent = true })

-- Buffer Management
-- map('n', '<M-c>', function()
--   vim.cmd(':Bdelete')
--   vim.cmd(':clear')
-- end, { desc = 'Close buffer', noremap = true })
-- map('n', '<M-.>', function()
--   vim.cmd(':bn')
--   vim.cmd(':clear')
-- end, { desc = 'Next buffer', noremap = true })
-- map('n', '<M-,>', function()
--   vim.cmd(':bp')
--   vim.cmd(':clear')
-- end, { desc = 'Previous buffer', noremap = true })

-- Sets X to cut the whole line
-- map('n', 'X', 'Vx', { silent = true })
