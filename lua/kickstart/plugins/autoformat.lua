return
{
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true, lsp_format = 'fallback' }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Format buffer or range",
    },
    {
      "<leader>ft",
      "<cmd>Ftoggle<cr>",
      mode = "n",
      desc = "Toggle autoformatting",
    }, {
    "<leader>fi",
    "<cmd>ConformInfo<cr>",
    mode = "n",
    desc = "Conform Info",
  },
  },
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
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return { timeout_ms = 500, lsp_format = lsp_format_opt }
    end,
    --NOTE: add the formatters to ensure_installed with add_tools function
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      python = { "isort", "black" },
      go = { "gofumpt", "goimports" },
      cshart = { "csharpier" },
    },
    formatters = {
      prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "--single-quote" } },
    }
  },
  init = function()
    -- [[ Toggle Autoformatting with Conform.nvim ]]
    vim.api.nvim_create_user_command("Ftoggle", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.b.disable_autoformat = vim.g.disable_autoformat
      local status = vim.g.disable_autoformat and "Disabled" or "Enabled"
      print("Auto Formatting is " .. status)
    end, { desc = "Toggle autoformatting" })
  end
}
