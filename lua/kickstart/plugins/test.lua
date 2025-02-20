return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        "nvim-neotest/neotest-go",
    },
    config = function()
        local function pattern(server_names)
            local lspconfig = require('lspconfig')
            local result = {}
            for _, server_name in ipairs(server_names) do
                local server_config = lspconfig[server_name]
                if server_config then
                    local filetypes = server_config.filetypes or {}
                    vim.list_extend(result, filetypes)
                else
                    vim.notify("LSP server " .. server_name .. " not found for neotest", vim.log.levels.ERROR)
                end
            end
            return result
        end

        -- get neotest namespace (api call creates or returns namespace)
        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message =
                        diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)

        local neotest = require("neotest")
        neotest.setup({
            -- your neotest config here
            adapters = {
                require("neotest-go"),
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            -- Put lsp server names here
            pattern = pattern({ 'gopls' }),
            callback = function()
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { desc = desc, buffer = true })
                end
                -- Refactored key mappings using the map function
                map("<leader>tr", function() neotest.run.run() end, "Run the Nearest test")
                map("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, "Run the current File")
                map("<leader>td", function() neotest.run.run(vim.fn.getcwd()) end,
                    "Run all tests in the current Directory")
                map("<leader>to", function() neotest.output.open({ auto_close = true }) end, "Show Test Output")
                map("<leader>tO", function() neotest.output_panel.toggle() end, "Toggle Output Panel")
                map("<leader>ts", function() neotest.summary.toggle() end, "Toggle Summary")
                map("<leader>tw", function() neotest.watch.toggle() end, "Toggle Watch")
                map("<leader>tW", function() neotest.watch.toggle(vim.fn.expand("%")) end, "Toggle Watch on file")
                map("]e", function() neotest.jump.next({ status = 'failed' }) end, "Failed Test Forward")
                map("[e", function() neotest.jump.prev({ status = 'failed' }) end, "Failed Test Backward")
                map("]E", function() neotest.jump.prev({ status = 'failed' }) end, "Failed Test Backward")
                map("[E", function() neotest.jump.next({ status = 'failed' }) end, "Failed Test Forward")
                -- Gopher mappings
                -- map("<leader>tg", "", "+Generate Tests")
                -- map("<leader>tga", "<cmd>GoTestAdd<cr>", "Generate a test for the function under cursor")
                -- map("<leader>tgA", "<cmd>GoTestsAll<cr>", "Generate tests for the functions in the file")
                -- map("<leader>tgE", "<cmd>GoTestsExp<cr>", "Generate tests for only the exported functions in the file")
            end,
        })
    end,
}
