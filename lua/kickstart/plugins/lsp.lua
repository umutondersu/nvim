return { -- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		{ 'williamboman/mason.nvim',      opts = {} },
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',

		-- For LSP actions preview
		{ 'aznhe21/actions-preview.nvim', opts = { backend = { "snacks", "nui" } } },

		-- Preview for go to methods
		{ 'rmagatti/goto-preview',        opts = { default_mappings = true, references = { provider = 'snacks' } }, event = 'VeryLazy', },

		-- Populates project-wide lsp diagnostcs
		'artemave/workspace-diagnostics.nvim',

		-- Provides keymaps for LSP actions
		'folke/snacks.nvim',

		-- Completion Plugin
		'saghen/blink.cmp',
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				map('gq', vim.diagnostic.open_float, 'Open floating diagnostic message')
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
				map('gy', Snacks.picker.lsp_type_definitions, 'Goto T[y]pe Definition')

				-- This is not Goto Definition, this is Goto Declaration.
				-- For example, in C this would take you to the header
				-- Many servers do not implement this method
				map('gD', Snacks.picker.lsp_declarations, 'Goto Declaration')

				-- Fuzzy find all the symbols.
				--  Symbols are things like variables, functions, types, etc.
				local kind_filter = { filter = require('kickstart.icons').kind_filter }
				map('<leader>ss', function() Snacks.picker.lsp_symbols(kind_filter) end, 'Symbols')

				-- Fuzzy find symbols in the workspace
				map('<leader>sS', function() Snacks.picker.lsp_workspace_symbols(kind_filter) end, 'Workspace Symbols')

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				map('<leader>rv', vim.lsp.buf.rename, 'Rename Variable')

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map('<leader>ca', require("actions-preview").code_actions, 'Code action')
				-- map('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

				-- Language specific configurations and keymaps
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Toggle Inlay Hints
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
					map('<leader>uh', function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
					end, 'Toggle Inlay Hints')
				end

				local function check_client(client_name)
					return client and client.name == client_name
				end

				if check_client('omnisharp') then
					map('gd', require('omnisharp_extended').lsp_definition, 'Goto Definition')
					map('gy', require('omnisharp_extended').lsp_type_definition,
						'Goto T[Y]pe Definition')
					map('gr', require('omnisharp_extended').lsp_references,
						'Goto References')
					map('gI', require('omnisharp_extended').lsp_implementation,
						'Goto Implementation')
				end

				if check_client('jdtls') then
					map('<leader>tc', require('java').test.run_current_class, 'Run Current Class')
					map('<leader>tm', require('java').test.run_current_method, 'Run Current Method')
					map('<leader>tr', require('java').test.view_last_report, 'View Last Report')
					map('<leader>ct', require('java').runner.built_in.toggle_logs, 'Toggle Logs')
					map('<leader>cv', require('java').refactor.extract_variable, 'Extract Variable')
					map('<leader>cV', require('java').refactor.extract_variable_all_occurrence,
						'Extract Variable All Occurrences')
					map('<leader>cc', require('java').refactor.extract_constant, 'Extract Constant')
					map('<leader>cm', require('java').refactor.extract_method, 'Extract Method')
					map('<leader>cf', require('java').refactor.extract_field, 'Extract Field')
				end

				if check_client('typescript-tools') then
					map('<leader>cm', '<cmd>TSToolsAddMissingImports<cr>', 'Add Missing Imports')
					map('<leader>co', '<cmd>TSToolsOrganizeImports<cr>', 'Sort and Remove Unused Imports')
					map('<leader>cf', '<cmd>TSToolsFixAll<cr>', 'Fix all fixable errors')
					map('<leader>cr', '<cmd>TSToolsRemoveUnused<cr>', 'Remove all unused statements')
					map('<leader>rf', '<cmd>TSToolsRenameFile<cr>', 'Rename File')
					-- Organize and Add Missing Import automatically
					vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
						pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
						callback = vim.schedule_wrap(function()
							if vim.g.disable_autoformat or vim.b[event.buf].disable_autoformat then
								return
							end
							vim.cmd('TSToolsAddMissingImports')
							vim.cmd('TSToolsOrganizeImports')
							vim.cmd('write')
						end),
						group = vim.api.nvim_create_augroup('ts-tools', {}),
					})
				end

				if check_client('gopls') then
					map('<leader>ct', function() require("gopher").tags.add "json" end, 'Add JSON Tags to struct')
					map('<leader>cc', '<cmd>GoCmt<cr>', 'Generate boilerplate for doc comments')
					map('<leader>so', '<cmd>GoDoc<cr>', 'Go Docs')
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP Specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- clangd = {},
			-- rust_analyzer = {},
			-- html = { filetypes = { 'html', 'twig', 'hbs'} },

			bashls = {},

			pyright = {},

			ts_ls = {},

			tailwindcss = {},

			dockerls = {},

			jsonls = {},

			lua_ls = {
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
			}

		}

		---@param command string
		---@param server_name string
		---@param server_config table?
		local function add_lsp(command, server_name, server_config)
			server_config = server_config or {}
			if vim.fn.executable(command) == 1 then
				servers[server_name] = server_config
			end
		end

		add_lsp('dotnet', 'omnisharp')

		add_lsp('go', 'gopls', {
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
			},
		})

		if vim.fn.executable('java') == 1 then
			require('java').setup()
		end
		add_lsp('java', 'jdtls')

		-- Grab the tools from the mason-tools.lua file and add them to the list of tools to install
		local ensure_installed = vim.tbl_keys(servers or {})
		local tools = require('kickstart.mason-tools')
		vim.list_extend(ensure_installed, tools)

		require('mason-tool-installer').setup { ensure_installed = ensure_installed }

		require('mason-lspconfig').setup {
			handlers = {
				function(server_name)
					-- Do not set up ts_ls since typescript-tools is used
					if server_name == 'ts_ls' then return end
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
					server.on_attach = function(client, bufnr)
						require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
					end
					require('lspconfig')[server_name].setup(server)
				end,
			}
		}
	end,
}
