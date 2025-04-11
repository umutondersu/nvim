local ft = { 'go', 'python', 'lua' }
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Inline virtual text for debugging
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },

    -- Debuggers for different languages
    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
    'jbyuki/one-small-step-for-vimkind', -- Neovim
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { '<leader>dr', function() require('dap').continue() end,                                            desc = 'Run/Continue',               ft = ft },
    { '<leader>di', function() require('dap').step_into() end,                                           desc = 'Step Into',                  ft = ft },
    { '<leader>do', function() require('dap').step_over() end,                                           desc = 'Step Over',                  ft = ft },
    { '<leader>dO', function() require('dap').step_out() end,                                            desc = 'Step Out',                   ft = ft },
    { '<leader>db', function() require('dap').toggle_breakpoint() end,                                   desc = 'Toggle Breakpoint',          ft = ft },
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Set Breakpoint w/condition', ft = ft },
    { '<Leader>dp', function() require('dap').pause() end,                                               desc = 'Pause',                      ft = ft },
    { '<leader>dt', function() require('dap').terminate() end,                                           desc = 'Terminate',                  ft = ft },
    { '<Leader>dR', function() require('dapui').toggle() end,                                            desc = 'Last Session Results',       ft = ft },
    { '<leader>de', function() require('dapui').eval() end,                                              desc = 'Eval',                       ft = ft, mode = { "n", "v" } },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local icons = require('kickstart.icons')

    -- Dap UI setup
    local dapui_icons = icons.dapui
    dapui.setup {
      icons = dapui_icons.icons,
      controls = {
        icons = dapui_icons.control_icons
      },
    }

    local dap_icons = icons.dap
    for name, sign in pairs(dap_icons) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        ---@diagnostic disable-next-line: assign-type-mismatch
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install language specific configurations
    local is_windows = vim.fn.has('win32') == 1
    local nvim_data_path = is_windows
        and vim.fn.expand('%LOCALAPPDATA%/nvim-data')
        or vim.fn.expand('~/.local/share/nvim')

    -- Python
    require('dap-python').setup(nvim_data_path .. '/mason/packages/debugpy/venv/bin/python')

    -- Go
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = not is_windows,
      },
    }

    -- Neovim
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
      }
    }
    dap.adapters.nlua = function(callback, config)
      callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
    vim.api.nvim_create_user_command('NeovimDebugStart', function() require "osv".launch({ port = 8086 }) end, {})
  end,
}
