-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set scrolloff
vim.opt.scrolloff = 15

-- Set tab width
vim.opt.tabstop = 4

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Relative Line number
vim.wo.relativenumber = true

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Disable Statusline
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.o.statusline = " "

-- Set default splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Custom diagnostic config
vim.diagnostic.config(
	{
		underline = false,
		virtual_text = {
			spacing = 2,
			prefix = "●",
			current_line = true,
			source = "if_many"
		},
		float = {
			border = "rounded",
			source = "if_many",
			header = "",
			prefix = ""
		},
		update_in_insert = false,
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = require('kickstart.icons').diagnostics.Error,
				[vim.diagnostic.severity.WARN] = require('kickstart.icons').diagnostics.Warn,
				[vim.diagnostic.severity.HINT] = require('kickstart.icons').diagnostics.Hint,
				[vim.diagnostic.severity.INFO] = require('kickstart.icons').diagnostics.Info,
			},
		},
	}
)

-- Disable Node Provider for windows
if vim.fn.has('win32') == 1 then
	vim.g.loaded_node_provider = 0
end
