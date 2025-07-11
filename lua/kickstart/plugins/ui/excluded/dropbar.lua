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
		},
		bar = {
			sources = function(buf, _)
				local sources = require('dropbar.sources')
				local utils = require('dropbar.utils')
				if vim.bo[buf].ft == 'markdown' then
					return {
						sources.path,
						sources.markdown,
					}
				end
				if vim.bo[buf].buftype == 'terminal' then
					return {
						sources.terminal,
					}
				end
				return {
					{
						---@diagnostic disable-next-line: redefined-local
						get_symbols = function(buf, win, cursor)
							local symbols = sources.path.get_symbols(buf, win, cursor)
							if vim.b[buf].pinned == 1 then
								symbols[#symbols].name = symbols[#symbols].name .. ' 📌'
							end
							return symbols
						end,
					},
					utils.source.fallback({
						sources.lsp,
						sources.treesitter,
					}),
				}
			end
		}
	},
	config = function(_, opts)
		require('dropbar').setup(opts)
		vim.keymap.set('n', '<m-d>', [[<cmd>lua require('dropbar.api').pick()<cr>]], { desc = 'Pick symbols in winbar' })
	end,
}
