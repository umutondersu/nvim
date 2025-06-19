local tw_ft = {
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
	ft = tw_ft,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	opts = {},
	keys = {
		{ "<leader>ct",  function() end,                                 desc = "Tailwind",                ft = tw_ft },
		-- Conceal toggles
		{ "<leader>ctc", function() vim.cmd.TailwindConcealToggle() end, desc = "Toggle Tailwind conceal", ft = tw_ft },
		-- Color hints toggles
		{ "<leader>ctC", function() vim.cmd.TailwindColorToggle() end,   desc = "Toggle Tailwind colors",  ft = tw_ft },
		-- Class navigation
		{ "]t",          function() vim.cmd.TailwindNextClass() end,     desc = "Next Tailwind class",     ft = tw_ft },
		{ "[t",          function() vim.cmd.TailwindPrevClass() end,     desc = "Previous Tailwind class", ft = tw_ft },
		{ "[T",          function() vim.cmd.TailwindNextClass() end,     desc = "Next Tailwind class",     ft = tw_ft },
		{ "]T",          function() vim.cmd.TailwindPrevClass() end,     desc = "Previous Tailwind class", ft = tw_ft },

	}
}
