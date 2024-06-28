return {
    "chrisgrieser/nvim-rip-substitute",
    keys = {
        {
            "<leader>rs",
            function() require("rip-substitute").sub() end,
            mode = { "n", "x" },
            desc = "[R]ip [S]ubstitute",
        },
    },
}
