return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash Jump" },
        { "<M-s>", mode = { "n", "o" },      function() require("flash").treesitter() end, desc = "Flash Treesitter Selection" },
    },
}
