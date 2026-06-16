return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
        },
      },
    },
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      theme = "wave", -- wave, dragon, lotus
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "moon", -- storm, moon, night, day
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
