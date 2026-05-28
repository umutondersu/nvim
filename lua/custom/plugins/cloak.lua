return {
    "laytan/cloak.nvim",
    config = function()
        require('cloak').setup()
        vim.keymap.set("n", "<leader>uc", "<cmd>CloakPreviewLine<cr>", { desc = "Uncloak Line" })
        local toggle_cloak = require("kickstart.util").toggle_keymap
        toggle_cloak(
            '<leader>uC',
            'Cloak',
            true,
            function() vim.cmd.CloakToggle() end
        )
    end
}
