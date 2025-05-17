return {
  'folke/tokyonight.nvim',
  lazy = true,
  priority = 1000,
  opts = function()
    if not vim.g.transparent then return {} end -- NOTE: transparency is set in init
    return {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      hide_inactive_statusline = true,
      on_highlights = function(hl, c)
        local line_number_color = "#898da0"
        local LineNr_hl_groups = { "LineNr", "LineNrAbove", "LineNrBelow" }
        for _, group in ipairs(LineNr_hl_groups) do
          hl[group] = { fg = line_number_color }
        end
        hl.TabLineFill = {
          bg = c.none,
        }
      end,
    }
  end,
  init = function()
    vim.g.transparent = not (os.getenv("NVIM_TRANSPARENT") == "false")
    vim.cmd.colorscheme 'tokyonight-night'
    vim.api.nvim_create_autocmd({ 'ColorScheme', 'BufAdd', 'VimEnter' }, {
      callback = vim.schedule_wrap(function()
        vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
        if not vim.g.transparent then return end

        vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "none", fg = "#545C7E" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "None" })
        vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { sp = "red" })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#232735", bg = "None" })
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1C1C23" })
      end),
      group = vim.api.nvim_create_augroup('Transparency', {}),
    })
    -- Autocmd for getting rid of statuslines in Avante for Transparent mode
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        if not vim.g.transparent then return end
        vim.api.nvim_set_hl(0, "AvanteSideBarWinSeparator", { fg = "#232735", bg = "None" })

        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(win) })
          if filetype == 'Avante' or filetype == 'AvanteSelectedFiles' then
            vim.api.nvim_set_option_value("winhl",
              "StatusLine:InvisibleStatusLine,StatusLineNC:InvisibleStatusLineNC", { win = win })
          end
        end
      end,
      group = vim.api.nvim_create_augroup('Transparency', { clear = false }),
    })
  end,
}
