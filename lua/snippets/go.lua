local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta

ls.add_snippets("go", {
	s({ trig = "ern", desc = "Create an if statement that checks if err is nil" }, fmt(
		[[
    if err != nil {
    <t><>
    }
    ]], {
			i(1), t = t("\t")
		})),

	s({ trig = "erv", desc = "Create an if statement to check the value of err" }, fmt(
		[[
    if err == <> {
    <t><>
    }
    ]], {
			i(1), i(2), t = t("\t")
		})),

	s({ trig = "er_", desc = "Create an if statement initilazing with the err value of a variable" }, fmt(
		[[
    if _, err := <>; err != nil {
    <t><>
    }
    ]], {
			i(1), i(2), t = t("\t")
		})),

})
