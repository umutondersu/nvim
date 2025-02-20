-- debug.lua
-- Shows how to use the DAP plugin to debug your code.
local ft = { 'go', 'python' }
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },

    -- Inline virtual text for debugging
    'theHamsta/nvim-dap-virtual-text',

    -- Debuggers for different languages
    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    { '<leader>cdr', function() require('dap').continue() end,                                            desc = 'Run/Continue',             ft = ft },
    { '<leader>cdi', function() require('dap').step_into() end,                                           desc = 'Step Into',                ft = ft },
    { '<leader>cdo', function() require('dap').step_over() end,                                           desc = 'Step Over',                ft = ft },
    { '<leader>cdO', function() require('dap').step_out() end,                                            desc = 'Step Out',                 ft = ft },
    { '<leader>cdt', function() require('dap').toggle_breakpoint() end,                                   desc = 'Toggle Breakpoint',        ft = ft },
    { '<leader>cds', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Set Breakpoint',           ft = ft },
    { '<Leader>cdR', function() require('dapui').toggle() end,                                            desc = 'See last session result.', ft = ft },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require("nvim-dap-virtual-text").setup({})

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    local dapui_icons = require('kickstart.icons').dapui
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      icons = dapui_icons.icons,
      controls = {
        icons = dapui_icons.control_icons
      },
    }

    local dap_icons = require('kickstart.icons').dap
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
