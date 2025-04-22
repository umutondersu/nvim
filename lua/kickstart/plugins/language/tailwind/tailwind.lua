local ft = {
	"html",
	"javascriptreact",
	"typescriptreact",
	"vue",
	"svelte",
	"astro",
	"php",
	"markdown",
}
return {
	"luckasRanarison/tailwind-tools.nvim",
	build = ":UpdateRemotePlugins",
	ft = ft,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	opts = {
		server = {
			settings = { capabilties = require('blink.cmp').get_lsp_capabilities() },
			on_attach = function(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end,
		}
	},
	keys = {
		{ "<leader>ct",  "<Nop>",                              desc = "Tailwind",                ft = ft },
		-- Conceal toggles
		{ "<leader>ctc", "<cmd>TailwindConcealToggle<CR>",     desc = "Toggle Tailwind conceal", ft = ft },
		-- Color hints toggles
		{ "<leader>ctC", "<cmd>TailwindColorToggle<CR>",       desc = "Toggle Tailwind colors",  ft = ft },
		-- Class sorting
		{ "<leader>cts", "<cmd>TailwindSortSync<CR>",          desc = "Sort Tailwind classes",   ft = ft },
		{ "<leader>cts", "<cmd>TailwindSortSelectionSync<CR>", desc = "Sort Tailwind classes",   ft = ft, mode = 'v' },
		-- Class navigation
		{ "]t",          "<cmd>TailwindNextClass<CR>",         desc = "Next Tailwind class",     ft = ft },
		{ "[t",          "<cmd>TailwindPrevClass<CR>",         desc = "Previous Tailwind class", ft = ft },
		{ "[T",          "<cmd>TailwindNextClass<CR>",         desc = "Next Tailwind class",     ft = ft },
		{ "]T",          "<cmd>TailwindPrevClass<CR>",         desc = "Previous Tailwind class", ft = ft },

	}
}
