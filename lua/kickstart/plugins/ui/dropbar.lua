return {
	'Bekaboo/dropbar.nvim',
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-web-devicons'
	},
	opts = {
		sources = {
			path = {
				modified = function(sym)
					return sym:merge({
						name = sym.name .. ' ',
						name_hl = '@comment.warning',
					})
				end
			}
		}
	},
	keys = {
		{
			'<m-d>',
			function() require('dropbar.api').pick() end,
			desc = 'Pick symbols in winbar'
		}
	}
}
