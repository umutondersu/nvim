return {
  'zbirenbaum/copilot.lua',
  enabled = vim.fn.has('macunix') == 0,
  build = ':Copilot auth',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    panel = { enabled = false },
    suggestion = { enabled = false },
    filetypes = {
      help = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ['.'] = false,
    },
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "none"
        }
      }
    }
  }
}
