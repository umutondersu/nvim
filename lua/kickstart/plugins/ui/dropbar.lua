return {
	'Bekaboo/dropbar.nvim',
	event = { "BufReadPost", "BufNewFile" },
	dependencies = 'nvim-web-devicons',
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
		},
		menu = {
			preview = false,
			keymaps = {
				['<BS>'] = '<C-w>q'
			}
		}
	},
	config = function()
		vim.keymap.set('n', '<m-d>', [[<cmd>lua require('dropbar.api').pick()<cr>]], { desc = 'Pick symbols in winbar' })
	end,
}
