return
{
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback'
        }
      end
    end,
    --NOTE: add the formatters to ensure_installed in mason-tools.lua
    formatters_by_ft = {
      javascript = { 'biome-check', 'biome-organize-imports' },
      typescript = { 'biome-check', 'biome-organize-imports' },
      javascriptreact = { 'biome-check', 'biome-organize-imports' },
      typescriptreact = { 'biome-check', 'biome-organize-imports' },
      json = { 'biome-check' },
      css = { 'biome-check' },
      html = { 'prettier' },
      yaml = { 'yamlfmt' },
      markdown = { 'prettier' },
      python = { 'isort', 'black' },
      go = { 'gofumpt', 'goimports' },
      csharp = { 'csharpier' },
      sh = { 'shellharden' },
      ruby = { 'rufo', 'rubocop' },
      nix = { 'nixfmt' }
    }
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true, lsp_format = 'fallback' })
      end,
      desc = "Format Buffer"
    },
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = 'fallback' }, function(err)
          if not err then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
          end
        end)
      end,
      mode = "x",
      desc = "Format Visual"
    },
    {
      "<C-f>",
      function()
        require("conform").format({ async = true, lsp_format = 'fallback' })
      end,
      mode = "i",
      desc = "Format Buffer"
    },
    {
      "<leader>fi",
      "<cmd>ConformInfo<cr>",
      mode = "n",
      desc = "Conform Info"
    },
  },
  init = function()
    -- [[ Toggle Autoformatting with Conform.nvim ]]
    local toggle_autoformatting = require("kickstart.util").toggle_keymap
    toggle_autoformatting('<leader>ft', 'Auto Format', not vim.g.disable_autoformat,
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.b.disable_autoformat = vim.g.disable_autoformat
        print('Auto Formatting is ' .. (vim.g.disable_autoformat and "Disabled" or "Enabled"))
      end)
  end
}
