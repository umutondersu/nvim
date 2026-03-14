return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  -- Recommended for `ask()` and `select()`.
  -- Required for `toggle()`.
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
        on_win = function(win)
          -- Set up keymaps and cleanup for an arbitrary terminal
          require('opencode.terminal').setup(win.win)
        end,
      },
    }
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
          require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }
    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { desc = desc })
    end

    -- Keymaps
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

    -- Smart toggle
    local function is_in_opencode_terminal()
      local buf = vim.api.nvim_get_current_buf()
      local snacks_info = vim.b[buf].snacks_terminal
      return snacks_info ~= nil and snacks_info.cmd == opencode_cmd
    end
    local function toggle_opencode()
      local closing = is_in_opencode_terminal()
      require("opencode").toggle()
      if closing then
        vim.cmd('wincmd p')
      else
        vim.cmd('wincmd l')
      end
    end

    map("<leader>at", toggle_opencode, "Toggle Opencode")
    map("<leader>at", function()
      vim.cmd('stopinsert')
      toggle_opencode()
    end, "Toggle Opencode", "t")
  end,
}
