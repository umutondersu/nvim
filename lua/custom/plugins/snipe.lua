return {
    "leath-dub/snipe.nvim",
    keys = {
        {
            "<M-z>",
            function() require("snipe").open_buffer_menu({ max_path_width = 2 }) end,
            desc = "Open Snipe [B]uffer Menu",
        },
    },
    opts = {
        hints = {
            -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
            dictionary = "asfghlwertyuiop",
        },
        navigate = {
            -- You can also just use normal navigation to go to the item you want
            -- this option just sets the keybind for selecting the item under the
            -- cursor
            under_cursor = "<cr>",

            -- In case you changed your mind, provide a keybind that lets you
            -- cancel the snipe and close the window.
            cancel_snipe = "q",
            -- close_buffer = "d",
        },
        -- Define the way buffers are sorted by default
        -- Can be any of "default" (sort buffers by their number) or "last" (sort buffers by last accessed)
        sort = "default",
    }
}
