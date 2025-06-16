require("mini.visits").setup()
require("mini.extra").setup()
require("mini.pick").setup({
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
