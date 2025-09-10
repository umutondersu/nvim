-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set scrolloff
vim.o.scrolloff = 15

-- Set tab width
vim.o.tabstop = 4

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
vim.o.laststatus = 0
vim.o.ruler = false
vim.o.statusline = " "

-- Set default splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Custom diagnostic config
local diag_icons = require('kickstart.icons').diagnostics
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
				[vim.diagnostic.severity.ERROR] = diag_icons.Error,
				[vim.diagnostic.severity.WARN] = diag_icons.Warn,
				[vim.diagnostic.severity.HINT] = diag_icons.Hint,
				[vim.diagnostic.severity.INFO] = diag_icons.Info,
			},
		},
	}
)

-- Disable Python Provider Maps
vim.g.no_python_maps = 1

-- Disable Node Provider for windows
if vim.fn.has('win32') == 1 then
	vim.g.loaded_node_provider = 0
end
