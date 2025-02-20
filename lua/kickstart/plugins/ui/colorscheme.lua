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
        if Transparent == true then
          vim.cmd('hi TreesitterContext guibg=none ')
          vim.cmd('hi TreesitterContextLineNumber guisp=Red')
        end
      end),
      group = vim.api.nvim_create_augroup('Transparency', {}),
    })
  end,

}
