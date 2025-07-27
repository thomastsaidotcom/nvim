-- Claude Code integration for Neovim
-- Provides seamless access to Claude Code CLI within Neovim
return {
	"greggh/claude-code.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		window = {
			position = "float",
			float = {
				width = "90%", -- Take up 90% of the editor width
				height = "90%", -- Take up 90% of the editor height
				row = "center", -- Center vertically
				col = "center", -- Center horizontally
				relative = "editor",
				border = "double", -- Use double border style
			},
		},
		command = "claude",
	},
}

