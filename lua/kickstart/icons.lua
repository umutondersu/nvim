return {
	misc = {
		dots = "󰇘",
	},
	ft = {
		octo = "",
	},
	dap = {
		Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint          = " ",
		BreakpointCondition = " ",
		BreakpointRejected  = { " ", "DiagnosticError" },
		LogPoint            = ".>",
	},
	dapui = {
		control_icons = {
			pause = '󰏤',
			play = '▶',
			step_into = '',
			step_over = '',
			step_out = '',
			step_back = '',
			run_last = '▶▶',
			terminate = '',
			disconnect = '',
		},
		icons = {
			expanded = '▾',
			collapsed = '▸',
			current_frame = '*',
		}
	},
	diagnostics = {
		Error = " ",
		Warn  = " ",
		Hint  = " ",
		Info  = " ",
	},
	git = {
		added    = " ",
		modified = " ",
		removed  = " ",
	},
	kind_icons = {
		Array         = " ",
		Boolean       = "󰨙 ",
		Class         = " ",
		Codeium       = "󰘦 ",
		Color         = " ",
		Control       = " ",
		Collapsed     = " ",
		Constant      = "󰏿 ",
		Constructor   = " ",
		Copilot       = " ",
		Enum          = " ",
		EnumMember    = " ",
		Event         = " ",
		Field         = " ",
		File          = " ",
		Folder        = " ",
		Function      = "󰊕 ",
		Interface     = " ",
		Key           = " ",
		Keyword       = " ",
		Method        = "󰊕 ",
		Module        = " ",
		Namespace     = "󰦮 ",
		Null          = " ",
		Number        = "󰎠 ",
		Object        = " ",
		Operator      = " ",
		Package       = " ",
		Property      = " ",
		Reference     = " ",
		Snippet       = "󱄽 ",
		String        = " ",
		Struct        = "󰆼 ",
		Supermaven    = " ",
		TabNine       = "󰏚 ",
		Text          = " ",
		TypeParameter = " ",
		Unit          = " ",
		Value         = " ",
		Variable      = "󰀫 ",
	},
	---@type table<string, string[]|boolean>?
	kind_filter = {
		default = {
			"Class",
			"Constructor",
			"Enum",
			"Field",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Namespace",
			"Package",
			"Property",
			"Struct",
			"Trait",
		},
		markdown = false,
		help = false,
		-- you can specify a different filter for each filetype
		lua = {
			"Class",
			"Constructor",
			"Enum",
			"Field",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Namespace",
			-- "Package", -- remove package since luals uses it for control flow structures
			"Property",
			"Struct",
			"Trait",
		},
	},

}
