return {
    "leath-dub/snipe.nvim",
    dependencies = 'echasnovski/mini.icons',
    keys = {
        { "<M-s>",      function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" },
        { "<leader>sb", function() require("snipe").open_buffer_menu() end, desc = "Snipe Buffers" }
    },
    opts = {
        sort = "last",
        ui = {
            position = "center",
            open_win_override = {
                title = "",
                border = "rounded"
            },
            text_align = 'file-first',

            buffer_format = { "icon", " ", "filename", function(buf)
                if vim.b[buf.id].pinned == 1 then return "📌" end
            end, " ", "directory" }
        },
        hints = {
            -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
            dictionary = "sadflewcmpghio",
        },
        navigate = {
            -- When the list is too long it is split into pages
            -- `[next|prev]_page` options allow you to navigate
            -- this list
            next_page = "J",
            prev_page = "K",

            -- You can also just use normal navigation to go to the item you want
            -- this option just sets the keybind for selecting the item under the
            -- cursor
            under_cursor = "<cr>",

            -- In case you changed your mind, provide a keybind that lets you
            -- cancel the snipe and close the window.
            cancel_snipe = { "<C-c>", "q" },

            -- Close the buffer under the cursor
            -- Remove "j" and "k" from your dictionary to navigate easier to delete
            -- NOTE: Make sure you don't use the character below on your dictionary
            close_buffer = "<C-d>",

            -- Open buffer in vertical split
            open_vsplit = "v",

            -- Open buffer in split, based on `vim.opt.splitbelow`
            open_split = "H",

            -- Change tag manually
            change_tag = "C",
        },
    }
}
