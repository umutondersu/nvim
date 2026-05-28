-- [[Language specific plugins]]
local module_prefix = 'kickstart.plugins.language.'
local cond = require('kickstart.util.conditions')

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
  local lang_specs = require(module_prefix .. name)
  local is_single_spec = type(lang_specs[1]) == 'table'
  local list = is_single_spec and lang_specs or { lang_specs }
  for _, spec in ipairs(list) do
    if c then spec.cond = c end
    table.insert(specs, spec)
  end
end

return specs
