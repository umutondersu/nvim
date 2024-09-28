return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>Q",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Toggle diagnostics [Q]uicklist",
        },
    }
}
