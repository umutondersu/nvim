return {
    'piersolenski/import.nvim',
    dependencies = 'folke/snacks.nvim',
    opts = {
        picker = "snacks",
    },
    keys = {
        {
            "<leader>ci",
            function()
                require("import").pick()
            end,
            desc = "Import Module",
        },
    },
}
