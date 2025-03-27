local Transparent = true
return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = function()
    if Transparent then
      return {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl)
          local LineNrHighlight = "#898da0"
          hl.LineNr = {
            fg = LineNrHighlight,
          }
          hl.LineNrAbove = {
            fg = LineNrHighlight,
          }
          hl.LineNrBelow = {
            fg = LineNrHighlight,
          }
        end,
      }
    end
    return {}
  end,
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'
    vim.api.nvim_create_autocmd({ 'ColorScheme', 'BufAdd' }, {
      callback = vim.schedule_wrap(function()
        if Transparent then
          local colors = require('tokyonight.colors').setup()
          vim.api.nvim_set_hl(0, "AvanteSideBarWinSeparator", { fg = colors.black, bg = "None" })
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "None" })
          vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { sp = colors.red })
        end
      end),
      group = vim.api.nvim_create_augroup('Transparency', {}),
    })
  end,

}
