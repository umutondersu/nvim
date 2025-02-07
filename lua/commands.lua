local general = vim.api.nvim_create_augroup("General Settings", { clear = true })

vim.api.nvim_create_user_command('Gc', function(args)
  local vimCmd = 'Git commit -m'
  if args['args'] then
    vimCmd = vimCmd .. ' ' .. args['args']
  end
  vim.cmd(vimCmd)
end, { desc = 'Commit with a message', nargs = '*' })

vim.api.nvim_create_user_command('Gp', 'Git push', { desc = 'git push' })

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

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
  group = general,
  desc = "Disable New Line Comment",
})

-- [[ Toggle Autoformatting with Conform.nvim ]]
vim.api.nvim_create_user_command("Ftoggle", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.b.disable_autoformat = vim.g.disable_autoformat
  local status = vim.g.disable_autoformat and "Disabled" or "Enabled"
  print("Auto Formatting is " .. status)
end, { desc = "Toggle autoformatting" })

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
