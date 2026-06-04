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

M.cargo      = function()
  return vim.fn.executable('cargo') == 1 and find_file('Cargo.toml') ~= ''
end

M.gem        = function()
  return vim.fn.executable('gem') == 1 and find_file('Gemfile') ~= ''
end

M.python     = function()
  if vim.fn.executable('python3') ~= 1 then return false end
  local output = vim.fn.system({
    'python3',
    '-c',
    'import sys; print(1 if sys.version_info >= (3, 10) else 0)'
  })
  return vim.trim(output) == '1'
end

M.java       = function()
  -- 1. Check if the java executable exists
  if vim.fn.executable('java') ~= 1 then return false end

  -- 2. Check if the directory contains standard Java project files
  local is_java_project = find_file('pom.xml') ~= ''
      or find_file('build.gradle') ~= ''
      or find_file('build.gradle.kts') ~= ''

  return is_java_project
end

M.nix        = function()
  local is_mac = vim.fn.has('macunix') == 1
  return not is_mac and vim.fn.executable('nix') == 1
end

M.npm        = function() return vim.fn.executable('npm') == 1 end
M.csharp     = function() return vim.fn.executable('dotnet') == 1 end
M.docker     = function() return find_file('Dockerfile') ~= '' end

--- Evaluate a condition (boolean or function)
---@param cond boolean|fun():boolean
---@return boolean
function M.eval(cond)
  if type(cond) == 'function' then return cond() end
  return cond
end

return M
