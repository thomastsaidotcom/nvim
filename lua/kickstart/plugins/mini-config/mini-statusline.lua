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
			
			-- Custom git section showing branch and hunk counts
			local git = ""
			local gitsigns_status = vim.b.gitsigns_status_dict
			if gitsigns_status then
				local branch = gitsigns_status.head or ""
				
				-- Get actual hunk counts from gitsigns cache
				local added_hunks = 0
				local changed_hunks = 0
				local removed_hunks = 0
				
				local cache = require("gitsigns.cache").cache[vim.api.nvim_get_current_buf()]
				if cache and cache.hunks then
					for _, hunk in ipairs(cache.hunks) do
						if hunk.added and hunk.added.count > 0 and (not hunk.removed or hunk.removed.count == 0) then
							added_hunks = added_hunks + 1
						elseif hunk.removed and hunk.removed.count > 0 and (not hunk.added or hunk.added.count == 0) then
							removed_hunks = removed_hunks + 1
						elseif hunk.added and hunk.removed then
							changed_hunks = changed_hunks + 1
						end
					end
				end
				
				local parts = {}
				if branch ~= "" then
					table.insert(parts, " " .. branch)
				end
				if added_hunks > 0 then table.insert(parts, "%#DiffAdd# +" .. added_hunks .. " %*") end
				if changed_hunks > 0 then table.insert(parts, "%#DiffChange# ~" .. changed_hunks .. " %*") end
				if removed_hunks > 0 then table.insert(parts, "%#DiffDelete# -" .. removed_hunks .. " %*") end
				
				if #parts > 0 then
					git = table.concat(parts, "")
				end
			end
			local diagnostics = statusline.section_diagnostics({})
			local mode = statusline.section_mode({})

			return statusline.combine_groups({
				relative_path,
				"%=",
				fileinfo and ("%#MiniStatuslineFileinfo# " .. fileinfo .. " ") or "",
				lsp_info ~= "" and ("%#MiniStatuslineLSP# " .. lsp_info .. " ") or "",
				git and git or "",
				diagnostics and ("%#MiniStatuslineDevinfo# " .. diagnostics .. " ") or "",
				"%#MiniStatuslineModeNormal# " .. mode .. " ",
			})
		end,
	},
})
