return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "clangd",
      "graphql-language-service-cli", -- required for graphql-lsp
    },
  },
}
