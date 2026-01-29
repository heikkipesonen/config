return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {},
    picker = {
      sources = {
        files = { hidden = true },
        grep = {
          hidden = true,
          args = { "--fixed-strings" },
        },
        explorer = { hidden = true },
      },
    },
  },
}
