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

-- [[ JS/JSX/TS/TSX ]] --
ls.add_snippets(all_js_file_types, {
  s({ trig = "clg", desc = "Output a message to the console" }, { t('console.log('), i(1), t(')') }),
}
)

-- [[ GO ]] --
ls.add_snippets("go", {
  s({ trig = "errn", desc = "Create an if statement that checks if err is nil" }, {
    t("if err != nil {"),
    t({ "", "\t" }), i(1),
    t({ "", "}" }),
  }),
})

ls.add_snippets("go", {
  s({ trig = "errv", desc = "Create an if statement to check the value of err" }, {
    t("if err == "), i(1), t("{"),
    t({ "", "\t" }), i(2),
    t({ "", "}" }),
  }),
})

ls.add_snippets("go", {
  s({ trig = "err_", desc = "Create an if statement initilazing with the err value of a variable" }, {
    t("if _, err =  "), i(1), t("; err != nil {"),
    t({ "", "\t" }), i(2),
    t({ "", "}" }),
  }),
})
