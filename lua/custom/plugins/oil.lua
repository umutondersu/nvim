local diag_icons = require('kickstart.util.icons').diagnostics
return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        dependencies = "echasnovski/mini.icons",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = not (#vim.fn.argv() == 1 and vim.fn.argv()[1] == "."),
            keymaps = {
                ["<bs>"] = { "actions.parent", mode = "n" },
                ["<esc>"] = { "actions.parent", mode = "n" },
                ["q"] = { "actions.close", mode = "n" },
                ["<leader>e"] = { "actions.close", mode = "n" },
                ["<C-e>"] = { "actions.close", mode = "n" },
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name == '..'
                end,
            },
            win_options = {
                winbar = "%#@comment#%{fnamemodify(v:lua.require('oil').get_current_dir(), ':~:.')}",
                signcolumn = "auto:2",
            }
        },
        keys = {
            { "<leader>e", "<cmd>Oil<cr>",   desc = "Toggle File Explorer" },
            { "<C-e>",     "<cmd>Oil .<cr>", desc = "File Explorer (cwd)" }
        }
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = "stevearc/oil.nvim",
        opts = {
            count = false,
            diagnostic_symbols = {
                error = diag_icons.Error,
                warn = diag_icons.Warn,
                info = diag_icons.Info,
                hint = diag_icons.Hint,
            }
        }
    },
    {
        "refractalize/oil-git-status.nvim",
        dependencies = "stevearc/oil.nvim",
        config = true,
    },
}
