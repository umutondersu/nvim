---@param keymap string
---@param keyword string
---@param initial boolean
---@param func fun()
---@param condfunc? fun(): boolean
local function toggle_keymap(keymap, keyword, initial, func, condfunc)
	local function toggle()
		initial = not initial
		func()
	end
	require('which-key').add({
		{
			keymap,
			function()
				if not condfunc then
					toggle()
				elseif condfunc() then
					toggle()
				end
				toggle_keymap(keymap, keyword, initial, func)
			end,
			desc = (initial and 'Disable' or 'Enable') .. ' ' .. keyword,
			icon = {
				icon = initial and '' or '',
				color = initial and 'green' or 'yellow'
			}

		}
	})
end

return { toggle_keymap = toggle_keymap }
