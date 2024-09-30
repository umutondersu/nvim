-- TODO: Needs to be integerated with barbar.nvim as it makes the Winbar clutered
return {
    'Bekaboo/dropbar.nvim',
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-web-devicons'
    },
    config = function()
        vim.keymap.set('n', '<leader>p', "<cmd>lua require('dropbar.api').pick()<cr>",
            { desc = '[P]ick mode for dropbar' })
    end
}
