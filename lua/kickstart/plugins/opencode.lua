return {
  "NickvanDyke/opencode.nvim",
  -- Recommended for `ask()` and `select()`.
  -- Required for `toggle()`.
  dependencies = "folke/snacks.nvim",
  enabled = vim.fn.executable('opencode') == 1,
  event = "VeryLazy",
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }
    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

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

    -- Keymaps
    map("<leader>at", function()
      require("opencode").toggle()
      vim.cmd('wincmd l')
    end, "Toggle Opencode")

    map("<leader>as", function() require("opencode").select() end, "Select Prompt", { "n", "x" })
    map("<leader>ae", function() require("opencode").ask("", { submit = true }) end, "Enter Prompt")

    map("<leader>aa", function() require("opencode").ask("@buffer: ", { submit = true }) end, "Ask Buffer")
    map("<leader>aA", function() require("opencode").ask("@buffers: ", { submit = true }) end, "Ask Open Buffers")

    map("<leader>ab", function() require("opencode").prompt("@buffer") end, "Add Buffer")
    map("<leader>aB", function() require("opencode").prompt("@buffers") end, "Add Open Buffers")

    map("<leader>ac", function() require("opencode").ask("@this: ", { submit = true }) end, "Ask Cursor Line", "n")
    map("<leader>av", function() require("opencode").ask("@this: ", { submit = true }) end, "Ask Visual", "v")

    map("<leader>ag", function() require("opencode").ask("@diff: ", { submit = true }) end, "Ask Git Diff")

    map("<leader>ad", function() require("opencode").ask("@diagnostics: ", { submit = true }) end, "Ask Diagnostics")
    map("<leader>aD", function() require("opencode").prompt("@diagnostics") end, "Add Diagnostics")

    map("<m-u>", function() require("opencode").command("session.half.page.up") end, "Messages half page up")
    map("<m-d>", function() require("opencode").command("session.half.page.down") end, "Messages half page down")

    map("<leader>an", function() require("opencode").command("session.new") end, "New Session")
    map("<leader>al", function()
      require("opencode").command("session.list")
      vim.cmd('wincmd l')
    end, "List Sessions")
  end,
}
