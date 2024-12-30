-- TODO: Needs to be integerated with barbar.nvim as it makes the Winbar clutered
return {
    'Bekaboo/dropbar.nvim',
    priority = 1000,
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-web-devicons'
    },
    config = function()
        local dropbar_api = require('dropbar.api')
        vim.keymap.set('n', '<m-X>', dropbar_api.pick,
            { desc = '[P]ick mode for dropbar' })
    end
}
