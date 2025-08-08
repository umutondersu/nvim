return {
    "wurli/urlpreview.nvim",
    event = "VeryLazy",
    opts = {
        -- If `true` an autocommand will be created to show a preview when the cursor
        -- rests over an URL. Note, this uses the `CursorHold` event which can take a
        -- while to trigger if you don't change your `updatetime`, e.g. using
        -- `vim.opt.updatetime = 500`.
        auto_preview = true,
        -- By default no keymap will be set. If set, this keymap will be applied in
        -- normal mode and will work when the cursor is over an URL.
        keymap = nil,
        -- The maximum width to use for the URL preview window.
        max_window_width = 100,
        -- Highlight groups; use `false` if you don't want highlights.
        hl_group_title = "@markup.heading",
        hl_group_description = "@markup.quote",
        hl_group_url = "Underlined",
        -- See `:h nvim_open_win()` for more options
        window_border = "rounded"
    }
}
