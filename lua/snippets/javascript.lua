local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta

local js_filetypes = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

-- [[ JS/JSX/TS/TSX ]] --
for _, ft in ipairs(js_filetypes) do
	ls.add_snippets(ft, {
		s({ trig = "clg", desc = "Output a message to the console" }, fmt('console.log(<>)', i(1))),
	})
end
