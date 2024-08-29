return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format { async = true, lsp_format = "fallback" }
        end,
        mode = { "n", "v" },
        desc = "Format buffer or range",
      },
      {
        "<leader>ft",
        function()
          vim.cmd "Ftoggle"
        end,
        mode = "n",
        desc = "Toggle autoformatting",
      }, {
      "<leader>fi",
      function()
        vim.cmd "ConformInfo"
      end,
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
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        -- lua = { "stylua" },
        python = { "isort", "black" },
        go = { 'gofumpt', 'goimports' },
      },
      -- Customize formatters
      -- formatters = {
      --     shfmt = {
      --         prepend_args = { '-i', '2' },
      --     },
      -- },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_user_command("Ftoggle", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.b.disable_autoformat = vim.g.disable_autoformat
        local status = vim.g.disable_autoformat and "Disabled" or "Enabled"
        print("Auto Formatting is " .. status)
      end, { desc = "Toggle autoformatting" })
    end,
  },
}
