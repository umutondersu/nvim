return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        cmdline = { view = "cmdline" },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            long_message_to_split = false, -- long messages will be sent to a split
            lsp_doc_border = true,         -- add a border to hover docs and signature help
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    find = "search hit BOTTOM",
                },
                skip = true
            },
            {
                filter = {
                    event = "msg_show",
                    find = "search hit TOP",
                },
                skip = true
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                skip = true,
            },
            {
                filter = {
                    event = "msg_show",
                    find = "change",
                },
                skip = true,
            },
            {
                filter = {
                    kind = "",
                    find = "yanked",
                },
                skip = true,
            },
            {
                filter = {
                    event = "msg_show",
                    find = "line",
                },
                skip = true,
            },
            {
                filter = {
                    event = "notify",
                    find = "Content is not an image.",
                },
                skip = true
            },
            {
                filter = {
                    event = "notify",
                    find = "not attached to buffer",
                },
                skip = true
            },
            -- {
            --     filter = {
            --         event = "notify",
            --         find = "No information available",
            --     },
            --     skip = true
            -- }
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        -- "rcarriga/nvim-notify"
    }
}
