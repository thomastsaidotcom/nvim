-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require("mini.statusline")
-- set use_icons to true if you have a Nerd Font
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

-- Shorten mode indicator to 2 letters with comments
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_mode = function()
	local mode_map = {
		n = "No",     -- Normal mode
		i = "In",     -- Insert mode
		v = "Vi",     -- Visual mode
		V = "VL",     -- Visual Line mode
		["\22"] = "VB", -- Visual Block mode (Ctrl-V)
		c = "Co",     -- Command mode
		s = "Se",     -- Select mode
		S = "SL",     -- Select Line mode
		["\19"] = "SB", -- Select Block mode (Ctrl-S)
		R = "Re",     -- Replace mode
		r = "Pr",     -- Prompt mode
		["!"] = "Sh", -- Shell mode
		t = "Te"      -- Terminal mode
	}
	local mode = vim.api.nvim_get_mode().mode
	return mode_map[mode] or mode:upper():sub(1,2)
end