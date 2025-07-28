-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

---------------------------------------------------------
-- Navigation
---------------------------------------------------------

-- Diagnostic navigation
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous error" })
vim.keymap.set("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })
vim.keymap.set("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Previous warning" })

-- Quickfix navigation
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix item" })


---------------------------------------------------------
-- End Navigation
---------------------------------------------------------


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

-- LSP navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

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

-- Custom LSP rename with buffer input
local function lsp_rename_with_buffer()
	local current_name = vim.fn.expand("<cword>")
	if current_name == "" then
		vim.notify("No symbol under cursor", vim.log.levels.WARN)
		return
	end

	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "cursor",
		width = math.max(20, #current_name + 10),
		height = 1,
		row = 1,
		col = 0,
		style = "minimal",
		border = "rounded",
		title = " LSP Rename ",
		title_pos = "center",
	})

	-- Set buffer content to current symbol name
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { current_name })

	-- Position cursor at end of the name
	vim.api.nvim_win_set_cursor(win, { 1, #current_name })

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "filetype", "text")

	-- Set up keymaps for the rename buffer
	local opts = { buffer = buf, nowait = true }

	-- Function to execute rename
	local function execute_rename()
		local new_name = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
		vim.api.nvim_win_close(win, true)

		if new_name and new_name ~= "" and new_name ~= current_name then
			vim.lsp.buf.rename(new_name)
		end
	end

	-- Execute rename on Enter
	vim.keymap.set("n", "<CR>", execute_rename, opts)

	-- Listen for save events on the buffer
	vim.api.nvim_create_autocmd({ "BufWriteCmd", "BufWritePre" }, {
		buffer = buf,
		callback = function()
			execute_rename()
		end,
	})

	-- Handle quit commands with save (:x, :wq, ZZ)
	vim.api.nvim_create_autocmd("QuitPre", {
		buffer = buf,
		callback = function()
			execute_rename()
		end,
	})

	-- Auto-close on buffer leave
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = buf,
		once = true,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end,
	})
end

vim.keymap.set("n", "<leader>cr", lsp_rename_with_buffer, { desc = "LSP [R]ename with buffer input" })

---------------------------------------------------------
-- Custom Commands
---------------------------------------------------------

-- Command to open :messages in a buffer
vim.api.nvim_create_user_command('MessagesB', function()
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- Open the buffer in a new window
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = vim.o.columns - 4,
    height = vim.o.lines - 6,
    row = 2,
    col = 2,
    style = 'minimal',
    border = 'rounded',
    title = ' Messages ',
    title_pos = 'center',
  })
  
  -- Get messages output
  local messages = vim.fn.execute('messages')
  local lines = vim.split(messages, '\n')
  
  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'filetype', 'messages')
  
  -- Set buffer name
  vim.api.nvim_buf_set_name(buf, '[Messages]')
  
  -- Move cursor to bottom
  vim.api.nvim_win_set_cursor(0, {#lines, 0})
end, { desc = 'Open :messages in a buffer window' })

-- Function to copy last message to clipboard
local function copy_last_message()
  local messages = vim.fn.execute('messages')
  local lines = vim.split(messages, '\n')
  
  -- Find the last non-empty line
  local last_message = ""
  for i = #lines, 1, -1 do
    if lines[i] and lines[i]:match('%S') then
      last_message = lines[i]
      break
    end
  end
  
  if last_message ~= "" then
    vim.fn.setreg('+', last_message)
    vim.notify('Copied last message to clipboard: ' .. last_message:sub(1, 50) .. (last_message:len() > 50 and '...' or ''))
  else
    vim.notify('No messages found', vim.log.levels.WARN)
  end
end

-- Keymap to copy last message
vim.keymap.set('n', '<leader>mc', copy_last_message, { desc = 'Copy last message to clipboard' })

---------------------------------------------------------
-- End Custom Commands
---------------------------------------------------------

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
