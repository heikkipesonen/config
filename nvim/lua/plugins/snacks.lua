return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    scroll = { enabled = false },
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
