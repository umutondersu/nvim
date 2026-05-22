-- [[Language specific plugins]]
local module_prefix = 'kickstart.plugins.language.'

local languages = {
  'lua',
  { 'go',         function() return vim.fn.findfile('go.mod', (vim.fn.getcwd() .. ';')) ~= '' end },
  { 'typescript', function() return vim.fn.findfile('tsconfig.json', (vim.fn.getcwd() .. ';')) ~= '' end },
  { 'tailwind', function()
    local f = vim.fn.findfile('package.json', (vim.fn.getcwd() .. ';'))
    if f == '' then return false end
    return table.concat(vim.fn.readfile(f --[[@as string]])):find('tailwind') ~= nil
  end },
  { 'java',   function() return vim.fn.executable('java') == 1 end },
  { 'csharp', function() return vim.fn.executable('dotnet') == 1 end },
}

local specs = {}
for _, entry in ipairs(languages) do
  local lang, cond
  if type(entry) == "string" then
    lang = entry
  else
    lang, cond = entry[1], entry[2]
  end
  local spec = { import = module_prefix .. lang }
  if cond then spec.cond = cond end
  table.insert(specs, spec)
end

return specs
