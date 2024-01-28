return {
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash Jump" },
        { "S", mode = { "n", "o" },      function() require("flash").treesitter() end, desc = "Flash Treesitter Selection" },
    },
}
