return {
	'Bekaboo/dropbar.nvim',
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		'nvim-telescope/telescope-fzf-native.nvim',
		'nvim-web-devicons'
	},
	config = function()
		local dropbar_api = require('dropbar.api')
		vim.keymap.set('n', '<m-d>', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
	end
}
