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
                ["cmp.entry.get_documentation"] = true,
            },
            progress = { enabled = false },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true,          -- use a classic bottom cmdline for search
            command_palette = true,        -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename = false,            -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,         -- add a border to hover docs and signature help
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                },
                opts = { skip = true },
            },
            -- {
            --     filter = {
            --         event = "msg_show",
            --         kind = "",
            --         find = "written",
            --     },
            --     opts = { skip = true },
            -- },
            -- {
            --     filter = {
            --         event = "msg_show",
            --         kind = "",
            --         find = "yanked",
            --     },
            --     opts = { skip = true },
            -- },
            -- {
            --     filter = {
            --         event = "msg_show",
            --         kind = "",
            --         find = "changes",
            --     },
            --     opts = { skip = true },
            -- },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 5,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
                border = {
                    style = "none",
                    padding = { 0, 1 },
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = 8,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
                filter_options = {},
            },
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
}

