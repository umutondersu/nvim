return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local cond = require('kickstart.util.conditions')
    local linters_by_ft = {}
    local function add_linter(condi, fts)
      if cond.eval(condi) then
        for ft, linters in pairs(fts) do
          linters_by_ft[ft] = linters
        end
      end
    end

    add_linter(cond.js, {
      javascript      = { 'biomejs' },
      typescript      = { 'biomejs' },
      javascriptreact = { 'biomejs' },
      typescriptreact = { 'biomejs' },
      json            = { 'biomejs' },
      css             = { 'biomejs' },
      sh              = { 'shellcheck' },
      markdown        = { 'markdownlint' },
    })
    add_linter(cond.python, {
      python = { 'flake8' },
    })
    add_linter(cond.go, {
      go = { 'golangcilint' },
    })
    add_linter(cond.gem, {
      ruby = { 'rubocop' },
    })
    -- fish has a built-in linter, no toolchain needed
    linters_by_ft.fish = { 'fish' }

    return { linters_by_ft = linters_by_ft }
  end,
  config = function(_, opts)
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
        if vim.bo.modifiable and not vim.g.disable_lint then
          lint.try_lint()
        end
      end)
    })

    -- [[ Toggle Linting with nvim-lint ]]
    local toggle_linting = require('kickstart.util').toggle_keymap
    local function toggle_fn()
      local current_linters = opts.linters_by_ft[vim.bo.filetype]
      vim.g.disable_lint = not vim.g.disable_lint
      if vim.g.disable_lint then
        for _, linter in ipairs(current_linters or {}) do
          local ns = lint.get_namespace(linter)
          vim.diagnostic.reset(ns)
        end
      else
        lint.try_lint()
      end
      print('Linting is ' .. (vim.g.disable_lint and 'disabled' or 'enabled'))
    end
    local function toggle_condition()
      local current_linters = opts.linters_by_ft[vim.bo.filetype]
      if not current_linters then
        vim.notify('No linters available for ' .. vim.bo.filetype, 3)
        return false
      end
      return true
    end
    toggle_linting('<leader>ul', 'Linting', not vim.g.disable_lint, toggle_fn, toggle_condition)

    -- [[ Disable linting if no linters are available ]]
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup("linter-init", { clear = true }),
      once = true,
      callback = function(e)
        local current_linters = opts.linters_by_ft[e.match]
        if not current_linters then
          vim.g.disable_lint = true
          toggle_linting('<leader>ul', 'Linting', false, toggle_fn, toggle_condition)
        end
      end
    })
  end,
}
