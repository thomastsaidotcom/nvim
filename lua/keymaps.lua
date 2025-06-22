-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

vim.keymap.set("n", "H", "gT", { desc = "Move to previous tab" })
vim.keymap.set("n", "L", "gt", { desc = "Move to next tab" })

-- Function to copy indentation from previous line
local function copy_prev_indent()
	local current_line = vim.fn.line(".")
	local prev_line = vim.fn.getline(current_line - 1)
	local indent = prev_line:match("^%s*")
	local current_text = vim.fn.getline(current_line):gsub("^%s*", "")
	vim.fn.setline(current_line, indent .. current_text)
end

-- Function to handle visual mode (multiple lines)
local function copy_prev_indent_visual()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	for line_num = start_line, end_line do
		local prev_line = vim.fn.getline(line_num - 1)
		local indent = prev_line:match("^%s*")
		local current_text = vim.fn.getline(line_num):gsub("^%s*", "")
		vim.fn.setline(line_num, indent .. current_text)
	end
end

-- Normal mode
vim.keymap.set("n", "<C-.>", copy_prev_indent, { desc = "Copy indentation from previous line" })

-- Insert mode
vim.keymap.set("i", "<C-.>", function()
	copy_prev_indent()
	-- Move cursor to end of line to continue typing
	vim.cmd("normal! $")
end, { desc = "Copy indentation from previous line" })

-- Visual mode
vim.keymap.set("v", "<C-.>", function()
	copy_prev_indent_visual()
	-- Exit visual mode
	vim.cmd("normal! gv")
end, { desc = "Copy indentation from previous line for selection" })

---------------------------------------------------------
-- Buffers
---------------------------------------------------------
-- Function to close all buffers except the current one
local function close_other_buffers()
	local bufs = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, i in ipairs(bufs) do
		if i ~= current_buf then
			vim.api.nvim_buf_delete(i, {})
		end
	end
end

-- Buffer management keybindings
vim.keymap.set("n", "<leader>bo", close_other_buffers, { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>bd", ":bd<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bn", ":tabnew<cr>", { desc = "Open new buffer" })

---------------------------------------------------------
-- End Buffers
---------------------------------------------------------

---------------------------------------------------------
-- Code
---------------------------------------------------------

-- Code Action
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- Set a lower updatetime for faster hover response
vim.o.updatetime = 250

-- Auto-show diagnostics on hover (without focus)
local function has_floating_window()
	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then -- This means it's a floating window
			return true
		end
	end
	return false
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		if not has_floating_window() then
			vim.diagnostic.open_float(nil, { focus = false })
		end
	end,
})

-- Manual keymap to focus diagnostic window with <leader>cd
vim.keymap.set("n", "<leader>cd", function()
	vim.diagnostic.open_float(nil, { focus = true })
end, { desc = "Line Diagnostics" })
---------------------------------------------------------
-- End Code Diagnostics
---------------------------------------------------------

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

--  -- Disable auto comment on new lines
vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- vim: ts=2 sts=2 sw=2 et
