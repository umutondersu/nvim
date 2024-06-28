return {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    opts = {},
    build = function() -- package settings
        vim.cmd [[silent! GoInstallDeps]]
    end,
}
