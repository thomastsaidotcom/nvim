-- Colorschemes collection
return {
  -- Nightfox colorscheme family
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
      }
    },
  },

  -- VSCode theme
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = true,
      disable_nvimtree_bg = true,
    },
  },

  -- Forest Night theme
  {
    "adibhanna/forest-night.nvim",
    priority = 1000,
  },

  -- Ayu Darker theme
  {
    "k4yt3x/ayu-vim-darker",
    priority = 1000,
  },

  -- PaperColor theme
  {
    "nlknguyen/papercolor-theme",
    priority = 1000,
  },

  -- Nord theme
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },

  -- Bluloco theme
  {
    "uloco/bluloco.nvim",
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    opts = {
      style = "auto",
      transparent = false,
      italics = false,
      terminal = vim.fn.has("gui_running") == 1,
    },
  },
}