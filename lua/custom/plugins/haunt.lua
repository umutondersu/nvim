return {
    "TheNoeTrevino/haunt.nvim",
    dependencies = "folke/which-key.nvim",
    event = "VeryLazy",
    ---@class HauntConfig
    opts = {},
    init = function()
        local haunt = require("haunt.api")
        local haunt_picker = require("haunt.picker")
        local map = vim.keymap.set
        local prefix = "<leader>n"

        -- annotations
        map("n", prefix .. "a", function()
            haunt.annotate()
        end, { desc = "Annotate" })

        local toggle_annotation = require('kickstart.util').toggle_keymap
        toggle_annotation(prefix .. "t", "Annoations", true, function()
            haunt.toggle_all_lines()
        end)

        map("n", prefix .. "d", function()
            haunt.delete()
        end, { desc = "Delete bookmark" })
        map("n", prefix .. "D", function()
            haunt.clear_all()
        end, { desc = "Delete all bookmarks" })

        -- picker
        map("n", prefix .. "l", function()
            haunt_picker.show()
        end, { desc = "Show Picker" })
        require("which-key").add({
            { "<leader>sh", function() haunt_picker.show() end, desc = "Hauntings", icon = "󱙝" },
        })

        -- quickfix
        map("n", prefix .. "q", function()
            haunt.to_quickfix()
        end, { desc = "Send Hauntings to QF Lix (buffer)" })
        map("n", prefix .. "Q", function()
            haunt.to_quickfix({ current_buffer = true })
        end, { desc = "Send Hauntings to QF Lix (all)" })

        -- yank
        map("n", prefix .. "y", function()
            haunt.yank_locations({ current_buffer = true })
        end, { desc = "Send Hauntings to Clipboard (buffer)" })
        map("n", prefix .. "Y", function()
            haunt.yank_locations()
        end, { desc = "Send Hauntings to Clipboard (all)" })

        -- move
        map("n", "]n", function()
            haunt.prev()
        end, { desc = "Previous Haunt" })
        map("n", "[n", function()
            haunt.next()
        end, { desc = "Next Haunt" })
        map("n", "[N", function()
            haunt.prev()
        end, { desc = "Previous Haunt" })
        map("n", "]N", function()
            haunt.next()
        end, { desc = "Next Haunt" })

        -- map("n", prefix .. "t", function()
        --     haunt.toggle_annotation()
        -- end, { desc = "Toggle annotation" })
    end,
}
