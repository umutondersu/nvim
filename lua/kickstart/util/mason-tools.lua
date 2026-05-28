-- NOTE: be sure tools are assigned in nvim-lint, nvim-dap, and conform.nvim
local cond = require('kickstart.util.conditions')

local ensure_installed = {}

local function add_tool(c, tools)
	if cond.eval(c) then
		vim.list_extend(ensure_installed, tools)
	end
end

add_tool(cond.js, {
	'biome',
	-- Linters
	'shellcheck',
	'markdownlint',
	-- DAP
	'js-debug-adapter'
})

add_tool(cond.cargo, {
	-- Formatters
	'shellharden',
})

add_tool(cond.python, {
	-- Formatters
	'black',
	'isort',
	-- DAP
	'debugpy',
	-- Linters
	'flake8'
})

add_tool(cond.csharp, {
	-- Formatters
	'csharpier'
})

add_tool(cond.go, {
	-- Formatters
	'gofumpt',
	'goimports',
	-- Linters
	'golangci-lint',
	-- DAP
	'delve',
	-- Gopher.nvim
	'gomodifytags',
	'gotests',
	'iferr',
	'impl'
})

add_tool(cond.gem, {
	'rufo',
	'rubocop'
})

add_tool(cond.nix, {
	--Formatters
	'nixfmt'
})

return ensure_installed
