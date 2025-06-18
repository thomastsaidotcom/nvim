require("mini.visits").setup()
require("mini.extra").setup()

---

local choose_all = function()
	local mappings = require("mini.pick").get_picker_opts().mappings
	vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
end

require("mini.pick").setup({
	mappings = {
		choose_in_tabpage = "<CR>",
		choose = "<C-r>",
		choose_all = { char = "<C-q>", func = choose_all },
	},
	window = {
		config = function()
			return {
				anchor = "NW",
				height = vim.o.lines,
				width = vim.o.columns,
				row = 0,
				col = 0,
			}
		end,
	},
})
