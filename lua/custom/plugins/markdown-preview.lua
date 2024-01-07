return {
  'iamcco/markdown-preview.nvim',
  lazy = true,
  config = function()
    vim.fn['mkdp#util#install']()
  end,
}
