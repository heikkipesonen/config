return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- ...elided other configs
      "graphql",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      debounce = 500,
    },
    incremental_selection = {
      enable = false,
    },
  },
}
