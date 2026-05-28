return { -- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		{ 'mason-org/mason.nvim',           opts = {} },
		{ 'mason-org/mason-lspconfig.nvim', opts = { automatic_enable = false } },
		'WhoIsSethDaniel/mason-tool-installer.nvim',

		-- For LSP actions preview
		{ 'aznhe21/actions-preview.nvim', opts = { backend = { "snacks", "nui" } } },

		-- Preview for go to methods
		{ 'rmagatti/goto-preview',        opts = { default_mappings = true, references = { provider = 'snacks' } }, event = 'VeryLazy', },

		-- Populates project-wide lsp diagnostcs
		'artemave/workspace-diagnostics.nvim',

		-- Provides keymaps for LSP actions
		'folke/snacks.nvim',
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode, lsp)
					mode = mode or 'n'
					lsp = lsp == nil and true or lsp
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = lsp and 'LSP: ' .. desc or desc })
				end

				-- Show the diagnostic message in a floating window
				map('gq', vim.diagnostic.open_float, 'Show Diagnostic Message')

				-- Opens a floating window showing hover information about the symbol under the cursor.
				--  This includes documentation, type information, and other details provided by the LSP.
				map('K', vim.lsp.buf.hover, 'Display Hover Information')

				---@module 'snacks'
				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map('gd', Snacks.picker.lsp_definitions, 'Goto Definition')


				-- Find references for the word under your cursor.
				map('gr', Snacks.picker.lsp_references, 'References')

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map('gI', Snacks.picker.lsp_implementations, 'Goto Implementation')

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map('gy', Snacks.picker.lsp_type_definitions, 'Goto Type Definition')

				-- This is not Goto Definition, this is Goto Declaration.
				-- For example, in C this would take you to the header
				-- Many servers do not implement this method
				map('gD', Snacks.picker.lsp_declarations, 'Goto Declaration')

				-- Fuzzy find all the symbols.
				--  Symbols are things like variables, functions, types, etc.
				local filter = require('kickstart.util.icons').kind_filter
				map('<leader>ss',
					function()
						Snacks.picker.lsp_symbols({
							filter = filter,
							layout = 'right',
						})
					end,
					'Symbols', 'n', false)

				-- Fuzzy find symbols in the workspace
				map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols({ filter = filter }) end,
					'Workspace Symbols', 'n', false)

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				map('<leader>rv', vim.lsp.buf.rename, 'Rename Variable', 'n', false)

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map('<leader>ca', require("actions-preview").code_actions, 'Code Action', { 'n', 'v' }) -- vim.lsp.buf.code_action
			end,
		})

		local cond = require('kickstart.util.conditions')

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--	- command (string?): This is an optinal key I added. If this key is not an executable, the LSP will be ignored.
		--  - req (fun():boolean): If provided and returns false, the server will be skipped entirely (not installed).
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- Feel free to add/remove any LSPs here that you want to install via Mason. They will automatically be installed and setup.
			mason = {
				-- clangd = {},
				-- rust_analyzer = {},
				-- html = { filetypes = { 'html', 'twig', 'hbs'} },

				bashls                = { req = cond.npm },

				ts_ls                 = { req = cond.js },

				tailwindcss           = { req = cond.tailwind },

				dockerls              = { req = cond.docker },

				jsonls                = { req = cond.npm },

				emmet_language_server = { req = cond.npm },

				sqlls                 = { req = cond.npm },

				lua_ls                = {
					settings = {
						Lua = {
							hint = { enable = true },
							telemetry = { enable = false },
							diagnostics = { disable = { 'missing-fields' } },
							completion = {
								callSnippet = 'Replace',
							},
						},
					},
				},

				basedpyright          = { req = cond.python },

				omnisharp             = { req = cond.csharp },

				gopls                 = {
					req = cond.go,
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					}
				},

				jdtls                 = { req = cond.java },

				ruby_lsp              = { req = cond.gem },
			},
			-- This table contains config for all language servers that are *not* installed via Mason.
			-- Structure is identical to the mason table from above. Apart from the custom req key
			others = {
				-- dartls = {},
				fish_lsp = {},
				nil_ls   = {},
			},
		}

		---@param config table
		local function skip_lsp(config)
			local req = config.req
			config.req = nil
			return req ~= nil and not cond.eval(req)
		end

		-- Configure Servers
		for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
			if skip_lsp(config) then
				servers.mason[server] = nil
			elseif not vim.tbl_isempty(config) then
				vim.lsp.config(server, config)
			end
			-- Skip ts_ls since typescript-tools.nvim manages it
			if server ~= 'ts_ls' then
				vim.lsp.enable(server)
			end
		end

		-- add workspace-diagnostics to all LSPs
		vim.lsp.config('*', {
			on_attach = function(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end
		})

		-- Grab the list of servers and tools to install and add them to ensure_installed
		local ensure_installed = vim.tbl_keys(servers.mason or {})
		local tools = require('kickstart.util.mason-tools')
		vim.list_extend(ensure_installed, tools)
		require('mason-tool-installer').setup { ensure_installed = ensure_installed }
	end,
}
