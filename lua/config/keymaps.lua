-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function GLogVisual()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local num_lines = end_line - start_line + 1
  local cmd = string.format(":G log -L%d,+%d:%%", start_line, num_lines)
  vim.cmd(cmd)
end

vim.api.nvim_set_keymap("v", "<leader>gl", ":<C-U>lua GLogVisual()<CR>", { noremap = true, silent = true })
