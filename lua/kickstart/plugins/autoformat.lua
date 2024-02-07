return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "n",
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
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        -- lua = { "stylua" },
        python = { "isort", "black" },
        go = { 'gofumpt', 'goimports' },
      },
      init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
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
        print("Setting autoformatting to: " .. tostring(not vim.g.disable_autoformat))
      end, { desc = "Toggle autoformatting" })
    end,
  },
}
