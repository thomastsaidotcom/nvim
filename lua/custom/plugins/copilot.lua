return {
	"github/copilot.vim",
	config = function()
		-- Accept suggestion with Tab
		vim.keymap.set("i", "<Tab>", function()
			if vim.fn["copilot#Accept"]() ~= "" then
				return vim.fn["copilot#Accept"]()
			else
				return "<Tab>"
			end
		end, { expr = true, replace_keycodes = false })
		
		-- Clear suggestion with Ctrl+e
		vim.keymap.set("i", "<C-e>", "<Plug>(copilot-dismiss)")
		
		-- Accept word with Ctrl+Tab
		vim.keymap.set("i", "<C-Tab>", "<Plug>(copilot-accept-word)")
		
		-- Disable for cpp files
		vim.g.copilot_filetypes = {
			cpp = false,
		}
	end,
}