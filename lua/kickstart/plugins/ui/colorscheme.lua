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
    vim.g.Transparent = true
    vim.cmd.colorscheme 'tokyonight-night'
    vim.api.nvim_create_autocmd({ 'ColorScheme', 'BufAdd' }, {
      callback = vim.schedule_wrap(function()
        if vim.g.Transparent then
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "None" })
          vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { sp = "red" })
        end
      end),
      group = vim.api.nvim_create_augroup('Transparency', {}),
    })
  end,

}
