return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = "folke/snacks.nvim",
  enabled = vim.fn.executable('opencode') == 1,
  event = "VeryLazy",
  config = function()
    local opencode_cmd = 'opencode --port'
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        position = 'right',
        width = 0.3,
        enter = false,
      },
    }
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }
    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<leader>aa", function() require("opencode").ask("@this: ") end,
      { desc = "Ask" })
    vim.keymap.set({ "n", "x" }, "<leader>ad", function() require("opencode").ask("@diagnostics: ") end,
      { desc = "Ask Diagnostics" })
    vim.keymap.set({ "n", "x" }, "<leader>as", function() require("opencode").select() end, { desc = "Select" })

    vim.keymap.set("v", "<lader>ay", function() return require("opencode").operator("@this ") end,
      { desc = "Append range", expr = true })
    vim.keymap.set("n", "<leader>ay", function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "Append line", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
      { desc = "Scroll OpenCode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
      { desc = "Scroll OpenCode down" })

    -- Can also leverage toggle functionality.
    -- Avoid <leader> here — Neovim watches for keymaps in terminal mode, so your leader key will have input delay.
    vim.keymap.set({ 'n', 't' }, '<leader>at', function()
      require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
    end, { desc = 'Toggle Window' })

    -- Optionally show upon submitting prompt
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'OpencodeEvent:tui.command.execute' },
      callback = function(args)
        ---@type opencode.server.Event
        local event = args.data.event
        if event.properties.command == 'prompt.submit' then
          local win = require('snacks.terminal').get(opencode_cmd, { create = false })
          if win then
            win:show()
          end
        end
      end,
    })
  end,
}
