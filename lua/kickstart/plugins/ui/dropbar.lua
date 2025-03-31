return {
	'Bekaboo/dropbar.nvim',
	priority = 1000,
	dependencies = {
		'nvim-telescope/telescope-fzf-native.nvim',
		'nvim-web-devicons'
	},
	config = function()
		local dropbar_api = require('dropbar.api')
		vim.keymap.set('n', '<m-d>', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
		if vim.g.Transparent then
			local dropbar_groups = {
				"DropBarIconKindVariable",
				"DropBarIconKindClass",
				"DropBarIconKindConstructor",
				"DropBarIconKindDeclaration",
				"DropBarIconKindEnum",
				"DropBarIconKindEnumMember",
				"DropBarIconKindEvent",
				"DropBarIconKindField",
				"DropBarIconKindIdentifier",
				"DropBarIconKindInterface",
				"DropBarIconKindMethod",
				"DropBarIconKindModule",
				"DropBarIconKindPackage",
				"DropBarIconKindProperty",
				"DropBarIconKindReference",
				"DropBarIconKindStruct",
				"DropBarIconKindTypeParameter",
				"DropBarIconKindType",
				"DropBarIconKindUnit",
				"DropBarKindVariable",
				"DropBarKindIdentifier",
			}
			for _, v in pairs(dropbar_groups) do
				vim.api.nvim_set_hl(0, v, { link = "" })
			end
		end
	end
}
