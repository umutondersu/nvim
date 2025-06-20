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
      python = { "uv_flake8" },
      go = { "golangcilint" },
      fish = { "fish" },
      sh = { "shellcheck" }
    }
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    -- Create a custom uv_flake8 linter
    local flake8 = lint.linters.flake8
    lint.linters.uv_flake8 = flake8
    lint.linters.uv_flake8.cmd = 'uv'
    lint.linters.uv_flake8.args = vim.list_extend({ 'run', 'flake8' }, flake8.args or {})

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
    local function toggle_linting()
      local enabled = not vim.g.disable_lint
      require("which-key").add({
        {
          '<leader>ul',
          function()
            local current_linters = opts.linters_by_ft[vim.bo.filetype]
            if vim.g.disable_lint and not current_linters then
              vim.notify('No linters available for ' .. vim.bo.filetype, 3)
              return
            end

            vim.g.disable_lint = not vim.g.disable_lint
            if vim.g.disable_lint then
              for _, linter in ipairs(current_linters) do
                local ns = lint.get_namespace(linter)
                vim.diagnostic.reset(ns)
              end
            else
              lint.try_lint()
            end
            print('Linting is ' .. (vim.g.disable_lint and 'disabled' or 'enabled'))
            toggle_linting()
          end,
          desc = (enabled and 'Disable' or 'Enable') .. ' Linting',
          icon = {
            icon = enabled and '' or '',
            color = enabled and 'green' or 'yellow'
          }
        }
      })
    end
    toggle_linting()

    -- [[ Disable linting if no linters are available ]]
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup("linter-init", { clear = true }),
      once = true,
      callback = function(e)
        local current_linters = opts.linters_by_ft[e.match]
        if not current_linters then
          vim.g.disable_lint = true
          toggle_linting()
        end
      end
    })

    -- [[ Disable linting for eslint_d on startup if no config file is found ]]
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup("eslint_d-startup", { clear = true }),
      pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      once = true,
      callback = function()
        local config_files = {
          'eslint.config.js',
          'eslint.config.mjs',
          'eslint.config.cjs',
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json'
        }
        local has_config = false
        -- Check for config files
        for _, config_file in ipairs(config_files) do
          if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config_file) == 1 then
            has_config = true
            break
          end
        end
        -- If no config found, disable linting
        if not has_config then
          vim.g.disable_lint = true
          toggle_linting()
        end
      end
    })
  end,
}
