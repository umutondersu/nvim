-- [[Language specific plugins]]
local module_prefix = 'kickstart.plugins.language.'
local language_requirements = {
  go = 'go',
  typescript = { 'node', 'npm' },
  tailwind = { 'node', 'npm' },
  java = 'java',
  csharp = 'dotnet',
}
local specs = { { import = 'kickstart.plugins.language.lua' } }

-- Filter modules based on available executables
for lang, req in pairs(language_requirements) do
  local module = module_prefix .. lang
  if type(req) == 'string' then
    -- Single requirement
    if vim.fn.executable(req) == 1 then
      table.insert(specs, { import = module })
    end
  elseif type(req) == 'table' then
    -- Multiple requirements - all must be present
    local all_available = true
    for _, cmd in ipairs(req) do
      if vim.fn.executable(cmd) ~= 1 then
        all_available = false
        break
      end
    end
    if all_available then
      table.insert(specs, { import = module })
    end
  end
end

return specs
