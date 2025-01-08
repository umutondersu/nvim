-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Inline virtual text for debugging
    'theHamsta/nvim-dap-virtual-text',

    -- Debuggers for different languages
    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { '<F5>',  function() require('dap').continue() end,                                            desc = 'Debug: Start/Continue' },
    { '<F11>', function() require('dap').step_into() end,                                           desc = 'Debug: Step Into' },
    { '<F10>', function() require('dap').step_over() end,                                           desc = 'Debug: Step Over' },
    { '<F12>', function() require('dap').step_out() end,                                            desc = 'Debug: Step Out' },
    { '<F6>',  function() require('dap').toggle_breakpoint() end,                                   desc = 'Debug: Toggle Breakpoint' },
    { '<F7>',  function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    { '<F8>',  function() require('dapui').toggle() end,                                            desc = 'Debug: See last session result.' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require("nvim-dap-virtual-text").setup({})
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'debugpy',
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '󰏤',
          play = '▶',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '▶▶',
          terminate = '',
          disconnect = '',
        },
      },
    }


    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install language specific configurations
    local is_windows = vim.fn.has 'win32'
    local nvim_data_path = '~/.local/share/nvim'

    -- Python
    if is_windows then
      nvim_data_path = '%LOCALAPPDATA%/nvim-data'
    end
    require('dap-python').setup(nvim_data_path .. '/mason/packages/debugpy/venv/bin/python')

    -- Go
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = is_windows == 0,
      },
    }
  end,
}
