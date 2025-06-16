-- - gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - gsd'   - [S]urround [D]elete [']quotes
-- - gsr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup({
	mappings = {
		add = "gsa", -- Add surrounding in Normal and Visual modes
		delete = "gsd", -- Delete surrounding
		find = "", -- Find surrounding (to the right)
		find_left = "", -- Disable find left surrounding
		highlight = "", -- Highlight surrounding
		replace = "gsr", -- Replace surrounding
		update_n_lines = "", -- Update `n_lines`
	},
})
