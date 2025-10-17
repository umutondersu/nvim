return {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
        },
        init = function()
            -- Reusable function to register keymaps in different contexts
            local function set_keymaps()
                vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
                vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>")
                vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>")
                vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>")
            end

            -- Register once globally
            set_keymaps()

            -- Re-register for terminal buffers to prevent literal command injection
            vim.api.nvim_create_autocmd("TermOpen", {
                callback = set_keymaps,
            })
        end,
    },
}
