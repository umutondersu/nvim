-- [[Language specific plugins]]
local module_prefix = 'kickstart.plugins.language.'
local cond = require('kickstart.conditions')

local languages = {
  { 'lua' },
  { 'go',         cond.go },
  { 'typescript', cond.typescript },
  { 'tailwind',   cond.tailwind },
  { 'java',       cond.java },
  { 'csharp',     cond.csharp },
}

local specs = {}
for _, entry in ipairs(languages) do
  local name, c = entry[1], entry[2]
  local spec = { import = module_prefix .. name }
  if c then spec.cond = c end
  table.insert(specs, spec)
end

return specs
