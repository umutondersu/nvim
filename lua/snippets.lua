local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local all_js_file_types = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

for _, filetype in pairs(all_js_file_types) do
  ls.add_snippets(filetype, {
    s({ trig = "clg", desc = "Output a message to the console" }, { t('console.log('), i(1), t(')') }),
  }
  )
end

