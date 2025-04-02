return {
  {
    "sonph/onehalf",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end,
  },
  {
    "NLKNguyen/papercolor-theme",
  },
  {
    "nordtheme/vim",
  },
  {
    "ayu-theme/ayu-vim",
  },
  {
    "navarasu/onedark.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
