-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>f",
        function() end,
        mode = "",
        desc = "[F]ormatter options",
      },
      {
        "<leader>fl",
        function() end,
        mode = "",
        desc = "LSP Formatting",
      },
      {
        "<leader>flf",
        function()
          vim.lsp.buf.format {
            async = false,
          }
        end,
        mode = "",
        desc = "Format buffer with LSP",
      },
      {
        "<leader>flt",
        function()
          vim.cmd "KickstartFormatToggle"
        end,
        mode = "",
        desc = "Toggle autoformatting for LSP",
      },
    },
    config = function()
      -- Switch for controlling whether you want autoformatting.
      --  Use :KickstartFormatToggle to toggle autoformatting on or off
      local format_is_enabled = false
      vim.api.nvim_create_user_command("KickstartFormatToggle", function()
        format_is_enabled = not format_is_enabled
        print("Setting autoformatting to: " .. tostring(format_is_enabled))
      end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = "kickstart-lsp-format-" .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == "tsserver" then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function() end,
        mode = "",
        desc = "[F]ormatter options",
      },
      {
        "<leader>ff",
        function()
          require("conform").format { async = false, lsp_fallback = true, timeout_ms = 500 }
        end,
        mode = "",
        desc = "Format buffer or range",
      },
      {
        "<leader>ft",
        function()
          vim.cmd "Ftoggle"
        end,
        mode = "",
        desc = "Toggle autoformatting",
      },
    },
    config = function()
      require("conform").setup {
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { async = false, timeout_ms = 500, lsp_fallback = true }
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
      }
      vim.api.nvim_create_user_command("Ftoggle", function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Setting autoformatting to: " .. tostring(not vim.g.disable_autoformat))
      end, { desc = "Toggle autoformatting" })
    end,
  },
}
