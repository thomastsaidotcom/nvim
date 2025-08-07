return {
	"echasnovski/mini.files",
	opts = {
		windows = {
			preview = true,
		},
		options = {
			use_as_default_explorer = true,
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				local current_file = vim.api.nvim_buf_get_name(0)
				if current_file ~= "" then
					require("mini.files").open(current_file, true)
				else
					require("mini.files").open()
				end
			end,
			desc = "Open mini.files in current file directory",
		},
		{
			"<leader>E",
			function()
				require("mini.files").open()
			end,
			desc = "Open mini.files picker",
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		-- Auto-close when file is opened and open in new tab
		local function map_split(buf_id, lhs, direction)
			local rhs = function()
				local new_target_window
				vim.api.nvim_win_call(require("mini.files").get_target_window() or 0, function()
					vim.cmd(direction .. " split")
					new_target_window = vim.api.nvim_get_current_win()
				end)

				require("mini.files").set_target_window(new_target_window)
				require("mini.files").go_in()
				require("mini.files").close()
			end

			vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
		end

		-- Open files in new tab by default (like nnn behavior)
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				-- Default behavior: open in new tab
				vim.keymap.set("n", "<CR>", function()
					local fs_entry = require("mini.files").get_fs_entry()
					if fs_entry and fs_entry.fs_type == "file" then
						require("mini.files").close()
						vim.cmd("tabedit " .. fs_entry.path)
					else
						require("mini.files").go_in()
					end
				end, { buffer = buf_id, desc = "Open in new tab" })

				-- Alternative: open in current buffer
				vim.keymap.set("n", "<C-r>", function()
					require("mini.files").go_in()
					require("mini.files").close()
				end, { buffer = buf_id, desc = "Open in current buffer" })

				-- Split mappings
				map_split(buf_id, "<C-s>", "horizontal")
				map_split(buf_id, "<C-v>", "vertical")
			end,
		})
	end,
}
