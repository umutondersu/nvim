return {
    'kosayoda/nvim-lightbulb',
    opts = {
        autocmd = { enabled = true },
        number = { enabled = true },
        sign = {
            enabled = true,
            -- Text to show in the sign column.
            -- Must be between 1-2 characters.
            text = "",
            -- Highlight group to highlight the sign column text.
            hl = "LightBulbSign",
        }
    }
}
