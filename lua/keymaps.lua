-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local map = vim.keymap.set
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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

-- Append line to bottom line while keeping cursor position
map("n", "J", "mzJ`z")

-- keep cursor centered while jumping around
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<M-u>", ":e!<CR>", { desc = 'Undo all unsaved writes' })

-- Shortcuts for save and exit
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save Buffer' })
map('n', '<leader>x', '<cmd>wqa<CR>', { desc = 'Save and Exit All Buffers' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit a Window' })

map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
	{ desc = 'Replace the word under cursor' })
map('v', '<leader>rv', function()
	-- Yank the visual selection into register z
	vim.cmd('normal! "zy')
	-- Get the yanked text from register z
	local selection = vim.fn.getreg("z")

	-- return if selection is empty
	if selection == "" then
		print("No text selected")
		return
	end
	vim.fn.setreg("z", "")

	-- Trim trailing whitespace from the selection
	selection = selection:gsub("%s+$", "")

	-- Escape special characters in the selection
	selection = vim.fn.escape(selection, '/\\')

	-- Replace newlines with a pattern that matches newlines in the buffer
	selection = selection:gsub("\n", "\\n")

	-- Construct the substitution command
	local cmd = string.format(':%s/%s/%s/gcI<Left><Left><Left><Left>', '%s', selection, selection)

	-- Set the command line to the constructed substitution command
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), 'n', true)
end, { desc = 'Replace the visual selection' })
