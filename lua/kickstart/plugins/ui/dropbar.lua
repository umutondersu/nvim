return {
	'Bekaboo/dropbar.nvim',
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-web-devicons'
	},
	keys = {
		{
			'<m-d>',
			function() require('dropbar.api').pick() end,
			desc = 'Pick symbols in winbar'
		}
	}
}
