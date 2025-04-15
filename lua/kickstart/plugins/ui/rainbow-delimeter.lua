return {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    submodules = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                commonlisp = rainbow_delimiters.strategy["local"],
            },
            query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterWhite",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterCyan",
                "RainbowDelimiterViolet",
                "RainbowDelimiterOrange",
                "RainbowDelimiterRed",
                "RainbowDelimiterGreen",
            },
            blacklist = {},
        })
    end,
}
