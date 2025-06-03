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
      csharp = { "csharpier" },
      sh = { "shellharden" }
    },
    formatters = {
      black = {
        command = 'uv',
        args = { 'run', 'black', '--stdin-filename', '$FILENAME', '--quiet', '-' },
      },
      isort = {
        command = 'uv',
        args = function(_, ctx)
          -- isort doesn't do a good job of auto-detecting the line endings.
          local line_ending
          local file_format = vim.bo[ctx.buf].fileformat
          if file_format == "dos" then
            line_ending = "\r\n"
          elseif file_format == "mac" then
            line_ending = "\r"
          else
            line_ending = "\n"
          end
          return {
            "run",
            "isort",
            "--stdout",
            "--line-ending",
            line_ending,
            "--filename",
            "$FILENAME",
            "-",
          }
        end
      },
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
    local function toggle_autoformatting()
      local enabled = not vim.g.disable_autoformat
      require("which-key").add({
        {
          '<leader>ft',
          function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            vim.b.disable_autoformat = vim.g.disable_autoformat
            print("Auto Formatting is " .. (enabled and "Disabled" or "Enabled"))
            toggle_autoformatting()
          end,
          desc = (enabled and 'Disable' or 'Enable') .. ' Formatting',
          icon = {
            icon = enabled and '' or '',
            color = enabled and 'green' or 'yellow'
          }
        }
      })
    end
    -- Initialize the mapping for the first time
    toggle_autoformatting()
  end
}
