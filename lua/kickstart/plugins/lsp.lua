return { -- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',

		-- For LSP actions preview
		'aznhe21/actions-preview.nvim',

		-- Preview for go to methods
		{ 'rmagatti/goto-preview', opts = {},  event = 'VeryLazy', },

		-- Populates project-wide lsp diagnostcs
		'artemave/workspace-diagnostics.nvim',

		-- Provides keymaps for LSP actions
		"folke/snacks.nvim",

		-- [[Language specific dependencies]]
		-- Typescript
		'dmmulroy/ts-error-translator.nvim',
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {
				settings = {
					tsserver_file_preferences = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					}
				},
			},
		},
		-- C#
		'Hoffs/omnisharp-extended-lsp.nvim',
		-- Java
		{
			'nvim-java/nvim-java',
			enabled = vim.fn.executable('java') == 1,
		},
		-- Lua
		{
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			'folke/lazydev.nvim',
			ft = 'lua',
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
				},
			},
		},
		{ "Bilal2453/luvit-meta",  lazy = true }, -- optional `vim.uv` typings
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				-- Diagnostic keymaps
				map('gq', vim.diagnostic.open_float, 'Open floating diagnostic message')

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
				map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

				-- Fuzzy find all the symbols.
				--  Symbols are things like variables, functions, types, etc.
				map('<leader>ss', Snacks.picker.lsp_symbols, 'Symbols')

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				map('<leader>rv', vim.lsp.buf.rename, 'Rename the variable under cursor')

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map('<leader>c', require("actions-preview").code_actions, 'Code action', { 'n', 'x' })
				-- map('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')


				-- Peek Keymaps
				map('gpd', require("goto-preview").goto_preview_definition,
					'Definition')
				map('gpy', require("goto-preview").goto_preview_type_definition,
					't[Y]pe Definition')
				map('gpi', require("goto-preview").goto_preview_implementation,
					'Implementation')
				map('gpD', require("goto-preview").goto_preview_declaration,
					'Declaration')

				-- Language specific keymaps
				local client = vim.lsp.get_client_by_id(event.data.client_id)

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
					map('<leader>tv', require('java').test.view_last_report, 'View Last Report')
				end

				if check_client('typescript-tools') then
					map('<leader>fa', '<cmd>TSToolsAddMissingImports<cr>', 'Add Missing Tools')
					map('<leader>fo', '<cmd>TSToolsOrganizeImports<cr>', 'Sort and Remove Unused Imports')
					map('<leader>rf', '<cmd>TSToolsRenameFile<cr>', 'Rename File')
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

			pyright = {},

			tailwindcss = {},

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
			},

		}

		---@param command string
		---@param server_name string
		---@param server_config table
		local function add_lsp(command, server_name, server_config)
			if vim.fn.executable(command) == 1 then
				servers[server_name] = server_config
			end
		end

		add_lsp('dotnet', 'omnisharp', {})

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
		add_lsp('java', 'jdtls', {})

		-- Ensure the servers and tools above are installed
		--  To check the current status of installed tools and/or manually install
		--  other tools, you can run
		--    :Mason
		--
		--  You can press `g?` for help in this menu
		require('mason').setup()

		-- Grab the tools from the mason-tools.lua file and add them to the list of tools to install
		local ensure_installed = vim.tbl_keys(servers or {})
		local tools = require('kickstart.mason-tools')
		vim.list_extend(ensure_installed, tools)

		require('mason-tool-installer').setup { ensure_installed = ensure_installed }

		require('mason-lspconfig').setup {
			handlers = {
				function(server_name)
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
			},
		}
	end,
}
