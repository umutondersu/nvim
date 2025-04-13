return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
    --NOTE: add the linters to ensure_installed with inside mason-tools.lua
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "flake8" },
      go = { "golangcilint" },
      fish = { "fish" },
      sh = { "shellcheck" }
    }
  },
  keys = {
    {
      "<leader>fl",
      "<cmd>LintToggle<cr>",
      desc = "Toggle Linting"
    }
  },
  config = function(_, opts)
    vim.g.disable_lint = false
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    local function debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function(...)
        local argv = { ... }
        if fn and timer then
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = debounce(100, function()
        if vim.opt_local.modifiable:get() and not vim.g.disable_lint then
          lint.try_lint()
        end
      end)
    })

    vim.api.nvim_create_user_command('LintToggle', function()
      vim.g.disable_lint = not vim.g.disable_lint
      local current_linters = opts.linters_by_ft[vim.bo.filetype]

      if vim.g.disable_lint and current_linters then
        for _, linter in ipairs(current_linters) do
          local ns = lint.get_namespace(linter)
          vim.diagnostic.reset(ns)
        end
      else
        lint.try_lint()
      end

      print('Linting is ' .. (vim.g.disable_lint and 'disabled' or 'enabled'))
    end, {})
  end,
}
