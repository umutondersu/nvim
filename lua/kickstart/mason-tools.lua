-- NOTE: be sure tools are assigned in nvim-lint, nvim-dap, and conform.nvim

local ensure_installed = {}

local function add_tool(command, tools)
	if vim.fn.executable(command) == 1 then
		vim.list_extend(ensure_installed, tools)
	end
end

add_tool('bash', {
	-- Linters
	'shellcheck'
})

add_tool('npm', {
	'biome',
	-- Formatters
	'prettier',
	-- Linters
	'shellcheck',
	-- DAP
	'js-debug-adapter'
})

add_tool('cargo', {
	-- Formatters
	'shellharden',
})

add_tool('python3', {
	-- Formatters
	'black',
	'isort',
	-- DAP
	'debugpy',
	-- Linters
	'flake8'
})

add_tool('dotnet', {
	-- Formatters
	'csharpier'
})

add_tool('go', {
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

add_tool('gem', {
	'rufo',
	'rubocop'
})

return ensure_installed
