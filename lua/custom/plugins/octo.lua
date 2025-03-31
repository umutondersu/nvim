return {
	'pwntester/octo.nvim',
	enabled = vim.fn.executable 'gh' == 1,
	cmd = { 'Octo' },
	dependencies = {
		'folke/snacks.nvim',
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	opts = { picker = 'snacks' }
}
