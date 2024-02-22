return {
    "olexsmir/gopher.nvim",
    dependencies = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    build = function() -- package settings
        vim.cmd [[silent! GoInstallDeps]]
    end,
}
