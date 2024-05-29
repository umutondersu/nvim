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
map('n', 'gq', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>Q', '<cmd>TroubleToggle<cr>', { desc = 'Toggle diagnostics list' })

-- jj for escaping insert mode
map('i', 'jj', '<Esc>', { silent = true })

-- Custom keymaps for turkish qwerty
map({ 'n', 'v' }, 'ş', '^', { silent = true }) -- move to first non-blank character
map('n', 'Ç', '>', { silent = true })
map('n', 'Ö', '<', { silent = true })
map({ 'n', 'v' }, 'Ğ', '{', { silent = true })
map({ 'n', 'v' }, 'Ü', '}', { silent = true })
map({ 'n', 'v' }, '+', '$', { silent = true }) -- move to end of line

-- New line without insert mode
map('n', '<M-o>', 'o<Esc>', { desc = 'New Line Down' })
map('n', '<M-O>', 'O<Esc>', { desc = 'New Line Up' })

-- Swap r and ctrl+r
map('n', '<C-r>', 'r', { silent = true }) -- replace a single character
map('n', 'r', '<C-r>', { silent = true }) -- redo

-- Sync only puts and x cuts with system clipboard (smartyank required)
map({ 'n', 'v' }, 'p', '"+p', { silent = true })
map({ 'n', 'v' }, 'P', '"+P', { silent = true })
map({ 'n', 'v' }, 'x', '"+d', { silent = true })
map({ 'n', 'v' }, 'X', '"+D', { silent = true })

-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Append line to bottom line while keeping cursor position
map("n", "J", "mzJ`z")

-- keep cursor centered while jumping around
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace the word under cursor' })

map("n", "<M-u>", ":e!<CR>", { desc = 'Undo all unsaved writes' })

map('n', '<leader>gw', '<cmd>G<cr>', { desc = '[G]it Summary [W]indow' })

-- Shortcuts for save and exit
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save Buffer' })
map('n', '<leader>x', '<cmd>wq<CR>', { desc = 'Save and Exit Buffer' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Exit Buffer' })

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
