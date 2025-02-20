return {
    'kosayoda/nvim-lightbulb',
    opts = {
        autocmd = { enabled = true },
        number = { enabled = true },
        sign = {
            enabled = true,
            text = "",
            hl = "LightBulbSign",
        },
        ignore = { clients = { 'gopls' } }
    }
}
