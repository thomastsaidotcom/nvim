return {
	"luukvbaal/nnn.nvim",
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
	opts = {},
}
