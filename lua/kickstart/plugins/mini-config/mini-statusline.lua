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
			
			-- Custom fileinfo section - only icon and filetype
			local filetype = vim.bo.filetype
			local icon = ""
			if vim.g.have_nerd_font and filetype ~= "" then
				-- Get filetype icon if available
				local ok, devicons = pcall(require, "nvim-web-devicons")
				if ok then
					local file_icon = devicons.get_icon_by_filetype(filetype)
					icon = file_icon and (file_icon .. " ") or ""
				end
			end
			local fileinfo = filetype ~= "" and (icon .. filetype) or ""
			
			-- Custom LSP count section
			local lsp_count = #vim.lsp.get_clients({ bufnr = 0 })
			local lsp_info = lsp_count > 0 and (lsp_count .. "Ⓛ") or ""
			
			local git = statusline.section_git({})
			local diagnostics = statusline.section_diagnostics({})
			local mode = statusline.section_mode({})

			return statusline.combine_groups({
				relative_path,
				"%=",
				fileinfo and ("%#MiniStatuslineFileinfo# " .. fileinfo .. " ") or "",
				lsp_info ~= "" and ("%#MiniStatuslineLSP# " .. lsp_info .. " ") or "",
				git and ("%#MiniStatuslineInactive# " .. git .. " ") or "",
				diagnostics and ("%#MiniStatuslineDevinfo# " .. diagnostics .. " ") or "",
				"%#MiniStatuslineModeNormal# " .. mode .. " ",
			})
		end,
	},
})
