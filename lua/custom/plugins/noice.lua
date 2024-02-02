return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
        cmdline = { view = "cmdline" },
        popupmenu = { enabled = false },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            progress = { enabled = false },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true,          -- use a classic bottom cmdline for search
            command_palette = true,        -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
    }
}
