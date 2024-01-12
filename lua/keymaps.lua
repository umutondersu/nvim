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
map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Custom keymaps
map({ 'n', 'v' }, 'ş', '^', { silent = true, desc = 'Start of line (non-blank)' }) -- move to first non-blank character
map('n', 'ç', '>', { silent = true })
map('n', 'ö', '<', { silent = true })
map({ 'n', 'v' }, 'ğ', '{', { silent = true })
map({ 'n', 'v' }, 'ü', '}', { silent = true })
map('i', 'jj', '<Esc>', { silent = true })
map({ 'n', 'v' }, '+', '$', { silent = true }) -- move to end of line
map('n', '<leader>o', 'o<Esc>', { desc = 'New Line Down' })
map('n', '<leader>O', 'O<Esc>', { desc = 'New Line Up' })

-- Swap r and ctrl+r
map('n', '<C-r>', 'r', { silent = true }) -- replace a single character
map('n', 'r', '<C-r>', { silent = true }) -- redo

map({ 'n', 'v' }, 'Ğ', function()
  map({ 'n', 'v' }, 'Ğ', '[')
  vim.cmd(':WhichKey [')
end, { silent = true })
map({ 'n', 'v' }, 'Ü', function()
  map({ 'n', 'v' }, 'Ü', ']')
  vim.cmd(':WhichKey ]')
end, { silent = true })

-- Sets d to delete and X to cut whole line
map('n', 'd', '"_d', { silent = true })
map('n', 'D', '"_D', { silent = true })
map('v', 'd', '"_d', { silent = true })
map('n', 'X', 'Vx', { silent = true })

