return {
  "NickvanDyke/opencode.nvim",
  -- Recommended for `ask()` and `select()`.
  -- Required for `toggle()`.
  dependencies = "folke/snacks.nvim",
  config = function()
    -- Your configuration, if any — see `lua/opencode/config.lua`
    vim.g.opencode_opts = {}
    -- Required for `vim.g.opencode_opts.auto_reload`
    vim.opt.autoread = true

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { desc = desc })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "opencode_ask",
      callback = function()
        map("<C-s>", "<CR>", "Input Enter", "i")
      end,
    })

    -- Recommended/example keymaps
    map("<leader>at", function()
      require("opencode").toggle()
      vim.cmd('wincmd l')
    end, "Toggle Opencode")

    map("<leader>as", function() require("opencode").select() end, "Select Prompt", { "n", "x" })

    map("<leader>aa", function() require("opencode").ask("@buffer: ", { submit = true }) end, "Ask Buffer")
    map("<leader>aA", function() require("opencode").ask("@buffers: ", { submit = true }) end, "Ask Open Buffers")

    map("<leader>ac", function() require("opencode").ask("@this: ", { submit = true }) end, "Ask Cursor Line", "n")
    map("<leader>av", function() require("opencode").ask("@this: ", { submit = true }) end, "Ask Visual", "v")

    map("<leader>ag", function() require("opencode").ask("@diff: ", { submit = true }) end, "Ask Git Diff")

    map("<leader>ad", function() require("opencode").ask("@diagnostics: ", { submit = true }) end, "Ask Diagnostics")
    map("<leader>aD", function()
      require("opencode").prompt("@diagnostics")
      vim.cmd('wincmd l')
    end, "Add Diagnostics")


    map("<leader>a/", function() require("opencode").command() end, "Select Command")
    map("<leader>an", function() require("opencode").command("session_new") end, "New Session")
    map("<leader>aS", function() require("opencode").command("session_interrupt") end, "Interrupt Session")
    map("<m-u>", function() require("opencode").command("messages_half_page_up") end, "Messages half page up")
    map("<m-d>", function() require("opencode").command("messages_half_page_down") end, "Messages half page down")
  end,
}
