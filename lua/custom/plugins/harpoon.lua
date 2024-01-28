return {
    "umutondersu/harpoon",
    branch = "harpoon2",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end
            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>.", function() toggle_telescope(harpoon:list()) end,
            { desc = "[.] Harpoon Buffers" })

        vim.keymap.set("n", "<M-x>", function() harpoon:list():append() end, { desc = "Harpoon Mark" })
        vim.keymap.set("n", "<M-X>", function() harpoon:list():remove() end, { desc = "Harpoon Unmark" })
        -- vim.keymap.set("n", "<leader>t", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        --     { desc = "Open harpoon window" })

        vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<M-6>", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<M-7>", function() harpoon:list():select(7) end)
        vim.keymap.set("n", "<M-8>", function() harpoon:list():select(8) end)
        vim.keymap.set("n", "<M-9>", function() harpoon:list():select(9) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<M-,>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<M-.>", function() harpoon:list():next() end)
        vim.keymap.set('n', '<M-c>', function()
            vim.cmd(':Bdelete')
            vim.cmd(':clear')
        end, { desc = 'Close buffer' })
    end,
}
