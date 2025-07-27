-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require("mini.statusline")
-- set use_icons to true if you have a Nerd Font
statusline.setup({
	use_icons = vim.g.have_nerd_font,
	content = {
		active = function()
			local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.") -- Force relative path
			local git = statusline.section_git({})
			local diagnostics = statusline.section_diagnostics({})
			local mode = statusline.section_mode({})

			return statusline.combine_groups({
				relative_path,
				"%=",
				git and ("%#MiniStatuslineInactive# " .. git .. " ") or "",
				diagnostics and ("%#MiniStatuslineDevinfo# " .. diagnostics .. " ") or "",
				"%#MiniStatuslineModeNormal# " .. mode .. " ",
			})
		end,
	},
})
