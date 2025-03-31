return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = function()
    if vim.g.Transparent then
      return {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        hide_inactive_statusline = true,
        on_highlights = function(hl)
          local line_number_color = "#898da0"
          local line_number_groups = { "LineNr", "LineNrAbove", "LineNrBelow" }
          for _, group in ipairs(line_number_groups) do
            hl[group] = { fg = line_number_color }
          end
        end,
      }
    end
    return {}
  end,
  init = function()
    vim.g.Transparent = true
    vim.cmd.colorscheme 'tokyonight-night'
    vim.api.nvim_create_autocmd({ 'ColorScheme', 'BufAdd' }, {
      callback = vim.schedule_wrap(function()
        if vim.g.Transparent then
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "None" })
          vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { sp = "red" })
          vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#232735", bg = "None" })
        end
      end),
      group = vim.api.nvim_create_augroup('Transparency', {}),
    })
    -- Autocmd for getting rid of statuslines in Avante for Transparent mode
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        if not vim.g.Transparent then
          return
        end
        vim.api.nvim_set_hl(0, "AvanteSideBarWinSeparator", { fg = "#232735", bg = "None" })
        vim.api.nvim_set_hl(0, "InvisibleStatusLine",
          { bg = "none", fg = "none", ctermbg = "none", ctermfg = "none" })
        vim.api.nvim_set_hl(0, "InvisibleStatusLineNC",
          { bg = "none", fg = "none", ctermbg = "none", ctermfg = "none" })

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
