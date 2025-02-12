vim.api.nvim_create_user_command('Gc', function(args)
  local vimCmd = 'Git commit -m'
  if args['args'] then
    vimCmd = vimCmd .. ' ' .. args['args']
  end
  vim.cmd(vimCmd)
end, { desc = 'Commit with a message', nargs = '*' })

vim.api.nvim_create_user_command('Gp', function(args)
  local vimCmd = 'Git push'
  if args['args'] then
    vimCmd = vimCmd .. ' ' .. args['args']
  end
  vim.cmd(vimCmd)
end, { desc = 'Git push', nargs = '*' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
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
    vim.opt_local.conceallevel = 0
  end,
})
