-- [[ Basic Keymaps ]]

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

-- [[  Plugin Keymaps ]]
-- [ barbar ]
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
-- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
-- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
-- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
-- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- [Nvim-tree]
map('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { silent = true, desc = 'Toggle NvimTree' })
