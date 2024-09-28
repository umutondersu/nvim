-- TODO: Needs to be integerated with barbar.nvim as it makes the Winbar clutered
return {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-web-devicons'
    },
    keys = {
        {
            "<leader>p",
            function() require('dropbar.api').pick() end,
            desc = "[P]ick Mode for Dropbar",
        },
    },
}
