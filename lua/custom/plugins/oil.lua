return {
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
        }
    },
    keys = {
        { "<C-e>", "<cmd>Oil<cr>",   desc = "Oil" },
        { "-",     "<cmd>Oil .<cr>", desc = "Oil cwd" }
    }
}
