return {
    'SuperBo/fugit2.nvim',
    config = function()
        local opts = {}
        if vim.fn.has('win32') == 1 then
            opts = {
                width = 70,
            }
        else
            opts = {
                width = 70,
                libgit2_path = 'libgit2.so.1.1'
            }
        end
        require("fugit2").setup(opts)
    end,
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
        {
            'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
            dependencies = { 'stevearc/dressing.nvim' }
        },
    },
    cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
    keys = {
        { '<leader>gF', mode = 'n', '<cmd>Fugit2<cr>', desc = '[F]ugit2' }
    }
}
