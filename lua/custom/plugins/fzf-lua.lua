-- Function to get visual selection text
local function get_visual_selection()
	-- Save the current register
	local save_reg = vim.fn.getreg('"')
	local save_regtype = vim.fn.getregtype('"')
	
	-- Yank the visual selection
	vim.cmd('normal! "xy')
	local selection = vim.fn.getreg('x')
	
	-- Restore the register
	vim.fn.setreg('"', save_reg, save_regtype)
	
	-- Clean up the selection (remove newlines and escape special chars)
	selection = selection:gsub('\n', ' '):gsub('  +', ' '):gsub('^%s+', ''):gsub('%s+$', '')
	
	return selection
end

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files", mode = "n" },
		{ "<leader>ff", function()
			local selection = get_visual_selection()
			require('fzf-lua').files({ query = selection })
		end, desc = "Find files with selection", mode = "v" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep", mode = "n" },
		{ "<leader>fg", function()
			local selection = get_visual_selection()
			require('fzf-lua').live_grep({ search = selection })
		end, desc = "Live grep with selection", mode = "v" },
		{ "<leader>/", "<cmd>FzfLua blines<cr>", desc = "Search in current buffer", mode = "n" },
		{ "<leader>/", function()
			local selection = get_visual_selection()
			require('fzf-lua').blines({ query = selection })
		end, desc = "Search in current buffer with selection", mode = "v" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
		{ "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Find colorschemes" },
		{ "gR", "<cmd>FzfLua lsp_references<cr>", desc = "Go to references" },
		{ "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
		{ "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
	},
	opts = {
		winopts = {
			fullscreen = true,
			preview = {
				layout = "vertical", -- horizontal|vertical|flex
				vertical = "up:60%",
			},
		},
		fzf_opts = {
			["--layout"] = "reverse-list",
		},
		files = {
			actions = {
				["default"] = function(selected, opts)
					local current_buf = vim.api.nvim_get_current_buf()
					local buf_name = vim.api.nvim_buf_get_name(current_buf)

					-- If buffer has a name (file is loaded), open in new tab
					if buf_name ~= "" then
						vim.cmd("tabnew")
					end
					require("fzf-lua").actions.file_edit_or_qf(selected, opts)
				end,
			},
		},
		keymap = {
			fzf = {
				["ctrl-d"] = "preview-page-down",
				["ctrl-u"] = "preview-page-up",
				["ctrl-q"] = "select-all+accept",
			},
		},
	},
}
