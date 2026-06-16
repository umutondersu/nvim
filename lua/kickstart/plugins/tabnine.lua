local raw_host = vim.env.TABNINE_HOST or ""
local tabnine_enterprise_host = raw_host:match("^https?://") and raw_host or ("https://" .. raw_host)
if raw_host ~= "" then vim.env.NODE_TLS_REJECT_UNAUTHORIZED = "0" end

return {
  "codota/tabnine-nvim",
  lazy = false,
  enabled = vim.fn.has('macunix') == 1,
  build = "./dl_binaries.sh " .. tabnine_enterprise_host .. "/update",
  config = function()
    if raw_host == "" then vim.notify("TABNINE_HOST is not set. TabNine will not work.", vim.log.levels.WARN) end
    require("tabnine").setup({
      disable_auto_comment = true,
      accept_keymap = "<C-s>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      codelens_color = { gui = "#808080", cterm = 244 },
      codelens_enabled = true,
      log_file_path = vim.fn.expand("~/.tabnine_nvim.log"),
      tabnine_enterprise_host = tabnine_enterprise_host,
      ignore_certificate_errors = true,
    })
  end,
  keys = {
    {
      '<leader>aa',
      '<cmd>TabnineAgent<cr>',
      desc = 'Open Agent'
    },
    {
      '<leader>aq',
      '<cmd>TabnineAgentClose<cr>',
      desc = 'Close Agent'
    },
    {
      '<leader>an',
      '<cmd>TabnineAgentNew<cr>',
      desc = 'New Agent'
    },
    {
      '<leader>ac',
      '<cmd>TabnineAgent<cr>',
      desc = 'Clear Agent'
    },
  }
}
