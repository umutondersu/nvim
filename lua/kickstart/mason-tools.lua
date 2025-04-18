-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
-- NOTE: be sure tools are assigned in nvim-lint, nvim-dap, and conform.nvim

local ensure_installed = {
	-- Formatters
	'prettier',
	-- Linters
	'eslint_d',
	'shellcheck',
	-- DAP
	'debugpy',
	'js-debug-adapter'
}

local function add_tool(command, tools)
	if vim.fn.executable(command) == 1 then
		vim.list_extend(ensure_installed, tools)
	end
end

add_tool('cargo', { 'shellharden' })

if vim.fn.executable('python3') == 1 then
	vim.fn.system('command -v python3-venv || sudo apt-get install -y python3-venv')
end
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

return ensure_installed
