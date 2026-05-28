return {
    "laytan/cloak.nvim",
    config = function()
        require('cloak').setup()
        vim.keymap.set("n", "<leader>uc", "<cmd>CloakPreviewLine<cr>", { desc = "Uncloak Line" })
        local enabled = true
        local function toggle_cloak()
            require("which-key").add({
                {
                    '<leader>uC',
                    function()
                        enabled = not enabled
                        vim.cmd.CloakToggle()
                        toggle_cloak()
                    end,
                    desc = (enabled and 'Disable' or 'Enable') .. ' Cloak',
                    icon = {
                        icon = enabled and '' or '',
                        color = enabled and 'green' or 'yellow'
                    }
                }
            })
        end
        toggle_cloak()
    end
}
