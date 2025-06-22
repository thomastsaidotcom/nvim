return {
	"supermaven-inc/supermaven-nvim",
	opts = {
		keymaps = {
			accept_suggestion = "<Tab>",
			clear_suggestion = "<C-e>",
			accept_word = "<C-Tab>",
		},
		ignore_filetypes = { cpp = true }, -- or { "cpp", }
	},
}
