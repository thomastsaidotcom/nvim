return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		keys = {
			{ "<leader>ff", "<cmd>Pick files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Pick grep_live<cr>", desc = "Live grep" },
			{
				"<leader>fr",
				"<cmd>Pick visit_paths cwd='' recency_weight=1<cr>",
				desc = "Recent files",
			},
		},
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			require("kickstart.plugins.mini-config.mini-pick")
			require("kickstart.plugins.mini-config.mini-surround")

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
