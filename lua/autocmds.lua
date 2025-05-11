-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- [[ Disable new line comment ]]
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = vim.api.nvim_create_augroup('disable_newline_comment', { clear = true }),
  desc = "Disable New Line Comment",
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup('json_conceal', { clear = true }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.bo.conceallevel = 0
  end,
})
