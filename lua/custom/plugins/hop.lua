return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	keys = {
		{
			"f",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end,
			mode = { "n", "x", "o" },
			remap = true,
		},
		{
			"F",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end,
			mode = { "n", "x", "o" },
			remap = true,
		},
		{
			"t",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end,
			mode = { "n", "x", "o" },
			remap = true,
		},
		{
			"T",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end,
			mode = { "n", "x", "o" },
			remap = true,
		},
	},
}