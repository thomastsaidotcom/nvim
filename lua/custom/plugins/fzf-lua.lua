return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		
		-- Helper function to determine if we should open in new tab
		local function should_open_in_new_tab()
			local current_buf = vim.api.nvim_get_current_buf()
			local buf_name = vim.api.nvim_buf_get_name(current_buf)
			
			-- If buffer has a name (file is loaded), open in new tab
			-- If it's an empty/unnamed buffer, use current tab
			return buf_name ~= ""
		end
		
		-- Custom action to handle smart tab opening
		local function smart_edit_action(selected, opts)
			if should_open_in_new_tab() then
				-- Open in new tab
				vim.cmd("tabnew")
			end
			-- Use default edit action
			fzf.actions.file_edit(selected, opts)
		end
		
		fzf.setup({
			"telescope",
			winopts = {
				height = 1.0,
				width = 1.0,
				preview = {
					layout = "vertical",
					vertical = "up:50%",
				},
			},
			keymap = {
				builtin = {
					["<C-q>"] = "select-all+accept",
				},
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
			actions = {
				files = {
					["default"] = smart_edit_action,
					["ctrl-r"] = fzf.actions.file_edit, -- Force current buffer
				},
			},
		})
	end,
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
		{ "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Find colorschemes" },
		{ "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Go to definition" },
		{ "gR", "<cmd>FzfLua lsp_references<cr>", desc = "Go to references" },
		{ "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Go to implementation" },
		{ "gt", "<cmd>FzfLua lsp_typedefs<cr>", desc = "Go to type definition" },
		{ "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
		{ "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
	},
}