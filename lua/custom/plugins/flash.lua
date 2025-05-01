return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
        { "S", mode = { "n", "o" },      function() require("flash").treesitter() end,        desc = "Flash Treesitter Selection" },
        { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
}
