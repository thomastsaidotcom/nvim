return {
	"tpope/vim-fugitive",
	config = function()
		-- Auto-move fugitive windows to new tabs
		local fugitive_group = vim.api.nvim_create_augroup("FugitiveToTab", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = fugitive_group,
			pattern = "fugitive://*",
			callback = function()
				-- Move the current window to a new tab
				vim.cmd("wincmd T")
			end,
			desc = "Auto-move fugitive windows to new tabs",
		})
	end,
}
