local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta

local all_js_file_types = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

-- [[ JS/JSX/TS/TSX ]] --
ls.add_snippets(all_js_file_types, {
  s({ trig = "clg", desc = "Output a message to the console" }, fmt('console.log(<>)', i(1))),
})

-- [[ GO ]] --
ls.add_snippets("go", {
  s({ trig = "errn", desc = "Create an if statement that checks if err is nil" }, fmt(
    [[
    if err != nil {
    <t><>
    }
    ]], {
      i(1), t = t("\t")
    })),
})

ls.add_snippets("go", {
  s({ trig = "errv", desc = "Create an if statement to check the value of err" }, fmt(
    [[
    if err == <> {
    <t><>
    }
    ]], {
      i(1), i(2), t = t("\t")
    })),
})

ls.add_snippets("go", {
  s({ trig = "err_", desc = "Create an if statement initilazing with the err value of a variable" }, fmt(
    [[
    if _, err := <>; err != nil {
    <t><>
    }
    ]], {
      i(1), i(2), t = t("\t")
    })),

})
