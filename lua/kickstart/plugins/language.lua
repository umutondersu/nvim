-- [[Language specific plugins]]
local language_requirements = {
  go = 'go',
  typescript = 'npm',
  tailwind = 'npm',
  java = 'java',
  csharp = 'dotnet',
}

local module_prefix = 'kickstart.plugins.language.'
local specs = { { import = module_prefix .. 'lua' } }

-- Filter modules based on available executables
for lang, cmd in pairs(language_requirements) do
  if vim.fn.executable(cmd) == 1 then
    local module = module_prefix .. lang
    table.insert(specs, { import = module })
  end
end

return specs
