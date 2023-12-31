return{
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { { "prettierd", "prettier" } },
                typescript = { { "prettierd", "prettier" } },
                javascriptreact = { { "prettierd", "prettier" } },
                typescriptreact = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                markdown = { { "prettierd", "prettier" } },
                html = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                lua = { { "stylua" } },
                -- python = {"isort", "black"},
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
        })
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
              lsp_fallback = true,
              async = false,
              timeout_ms = 500,
            })
          end, { desc = "Format file or range (in visual mode)" })
    end,
}