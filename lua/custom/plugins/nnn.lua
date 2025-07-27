return {
	"luukvbaal/nnn.nvim",
	opts = function()
		local builtin = require("nnn").builtin
		return {
			picker = {
				cmd = "nnn",
				style = {
					width = 0.9,
					height = 0.8,
					border = "rounded",
				},
			},
			mappings = {
				{ "<CR>", builtin.open_in_tab }, -- Enter: new tab (your default)
				{ "<C-r>", builtin.open }, -- Ctrl+e: current buffer
			},
		}
	end,

	keys = {
		{
			"<leader>e",
			function()
				local current_dir = vim.fn.expand("%:p:h")
				vim.cmd("NnnPicker " .. current_dir)
			end,
			desc = "Open nnn picker in current file directory",
		},
		{ "<leader>E", "<cmd>NnnPicker<cr>", desc = "Open nnn picker" },
	},
}
