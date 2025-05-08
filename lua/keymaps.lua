-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local map = vim.keymap.set

-- Delete some default LSP keymaps
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gO')

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

-- Append line from bottom line while keeping cursor position
map("n", "J", "mzJ`z")

-- keep cursor centered while jumping around
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map('v', '<', '<gv', { desc = 'Shift Left' })
map('v', '>', '>gv', { desc = 'Shift Right' })

map("n", "<M-u>", ":e!<CR>", { desc = 'Undo all unsaved writes' })

-- Shortcuts for save and exit
map('n', '<leader>w', function()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == '' then
		-- Buffer has no name, prompt for one
		vim.ui.input({
			prompt = 'Enter file name: ',
		}, function(name)
			if name and name ~= '' then
				vim.cmd('write ' .. vim.fn.fnameescape(name))
			end
		end)
		return
	end
	-- Buffer has a name, save normally
	vim.cmd.write()
end, { desc = 'Save Buffer' })
map('n', '<leader>x', '<cmd>wqa<CR>', { desc = 'Save and Exit' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit Window' })

-- Refactor Keymaps
map("n", "<leader>rF", function()
	local filepath = vim.fn.expand('%')
	vim.ui.input({
		prompt = string.format("Delete %s? [y/n] ", vim.fn.fnamemodify(filepath, ":t")),
	}, function(confirm)
		if confirm and confirm:lower() == 'y' then
			local success, err = os.remove(filepath)
			if success then
				vim.cmd('bdelete!')
				vim.notify(string.format("Deleted %s", filepath), vim.log.levels.INFO)
			else
				vim.notify(string.format("Failed to delete %s: %s", filepath, err), vim.log.levels.ERROR)
			end
		end
	end)
end, { desc = 'Remove File' })
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
	{ desc = 'Replace Word' }) -- Replace the word under the cursor
map('v', '<leader>rv', function()
	-- Yank the visual selection into register v
	vim.cmd('normal! "vy')
	local selection = vim.fn.getreg("v")

	if selection == "" then
		print("No text selected")
		return
	end
	vim.fn.setreg("v", "")

	-- Sanitize the selection
	selection = selection:gsub("%s+$", "")
	selection = vim.fn.escape(selection, '/\\')
	selection = selection:gsub("\n", "\\n")

	local cmd = string.format(':%s/%s/%s/gcI<Left><Left><Left><Left>', '%s', selection, selection)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), 'n', true)
end, { desc = 'Replace Visual' })

-- Resize window using <ctrl> arrow keys with smart behavior
map("n", "<C-Up>", function()
	local win_id = vim.fn.winnr()
	local above_win = vim.fn.winnr('k')

	if above_win == win_id then
		vim.cmd('resize -2')
	else
		vim.cmd('resize +2')
	end
end, { desc = "Increase Window Height" })

map("n", "<C-Down>", function()
	local win_id = vim.fn.winnr()
	local above_win = vim.fn.winnr('k')

	if above_win == win_id then
		vim.cmd('resize +2')
	else
		vim.cmd('resize -2')
	end
end, { desc = "Decrease Window Height" })

map("n", "<C-Right>", function()
	local win_id = vim.fn.winnr()
	local left_win = vim.fn.winnr('h')

	if left_win == win_id then
		vim.cmd('vertical resize +2')
	else
		vim.cmd('vertical resize -2')
	end
end, { desc = "Increase Window Width" })

map("n", "<C-Left>", function()
	local win_id = vim.fn.winnr()
	local left_win = vim.fn.winnr('h')

	if left_win == win_id then
		vim.cmd('vertical resize -2')
	else
		vim.cmd('vertical resize +2')
	end
end, { desc = "Decrease Window Width" })
