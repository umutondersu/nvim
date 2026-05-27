-- [[Shared availability conditions]]
-- Used by language.lua, mason-tools.lua, lsp.lua, lint.lua, and autoformat.lua

local M = {}

local function find_file(name)
  return vim.fn.findfile(name, (vim.fn.getcwd() .. ';'))
end

M.lua        = true
M.go         = function()
  return vim.fn.executable('go') == 1 and
      find_file('go.mod') ~= ''
end
M.js         = function()
  local f = find_file('package.json')
  return M.npm() and f ~= ''
end
M.typescript = function()
  return M.js() and find_file('tsconfig.json') ~= ''
end
M.tailwind   = function()
  local f = find_file('package.json')
  return M.npm() and f ~= '' and table.concat(vim.fn.readfile(f --[[@as string]])):find('tailwind') ~= nil
end
M.npm        = function() return vim.fn.executable('npm') == 1 end
M.java       = function() return vim.fn.executable('java') == 1 end
M.csharp     = function() return vim.fn.executable('dotnet') == 1 end
M.python     = function() return vim.fn.executable('python3') == 1 end
M.cargo      = function() return vim.fn.executable('cargo') == 1 end
M.gem        = function() return vim.fn.executable('gem') == 1 end
M.nix        = function() return vim.fn.executable('nix') == 1 end
M.docker     = function() return find_file('Dockerfile') ~= '' end

--- Evaluate a condition (boolean or function)
---@param cond boolean|fun():boolean
---@return boolean
function M.eval(cond)
  if type(cond) == 'function' then return cond() end
  return cond
end

return M
