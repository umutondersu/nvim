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

-- All JS file types
-- console.log
for _, filetype in pairs(all_js_file_types) do
  ls.add_snippets(filetype, {
    s({ trig = "clg", desc = "Output a message to the console" }, { t('console.log('), i(1), t(')') }),
  }
  )
end

-- GO
-- nil err check
ls.add_snippets("go", {
  s({ trig = "errn", desc = "Nil Error check" }, {
    t("if err != nil {"),
    t({ "", "\t" }), i(1),
    t({ "", "}" }),
  }),
})


ls.add_snippets("go", {
  s({ trig = "errif", desc = "If Error check" }, {
    t("if err == "), i(1), t("{"),
    t({ "", "\t" }), i(2),
    t({ "", "}" }),
  }),
})
