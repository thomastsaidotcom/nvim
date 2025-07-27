-- Claude Code integration for Neovim
-- Provides seamless access to Claude Code CLI within Neovim
return {
  "greggh/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("claude-code").setup({
      window = {
        position = "float",
        float = {
          width = "90%",      -- Take up 90% of the editor width
          height = "90%",     -- Take up 90% of the editor height
          row = "center",     -- Center vertically
          col = "center",     -- Center horizontally
          relative = "editor",
          border = "double",  -- Use double border style
        },
      },
      command = "claude",
    })

    -- Custom keymaps with <leader>a prefix (AI)
    local keymap = vim.keymap.set

    keymap("n", "<leader>at", function()
      require("claude-code").toggle()
    end, { desc = "[A]I Claude Code [T]oggle" })

    keymap("n", "<leader>ac", function()
      require("claude-code").toggle({ continue = true })
    end, { desc = "[A]I Claude Code [C]ontinue" })

    keymap("n", "<leader>av", function()
      require("claude-code").toggle({ verbose = true })
    end, { desc = "[A]I Claude Code [V]erbose" })

    keymap("n", "<leader>ar", function()
      require("claude-code").resume()
    end, { desc = "[A]I Claude Code [R]esume conversation" })

    keymap("n", "<leader>ao", function()
      require("claude-code").toggle()
    end, { desc = "[A]I Claude Code [O]pen" })

    -- Custom escape mapping for Claude Code buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "claude-code",
      callback = function()
        vim.keymap.set("i", "<C-[>", "<Esc>", { buffer = true, silent = true })
        vim.keymap.set("i", "jk", "<Esc>", { buffer = true, silent = true })
      end,
    })
  end,
}