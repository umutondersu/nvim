local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local react_filetypes = { 'typescriptreact', 'javascriptreact' }
for _, ft in ipairs(react_filetypes) do
	ls.add_snippets(ft, {
		s({ trig = "stte", desc = "Create a useState hook" }, fmt(
			[[
	const [<>, set<>] = useState(<>);
	]], {
				i(1),
				rep(1), -- Same as first input
				i(2)
			}))
	})
end
