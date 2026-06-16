return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = { enabled = false },
      ts_ls = { enabled = false },
      tsgo = {
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
      },
      graphql = {
        filetypes = { "graphql", "typescript", "typescriptreact", "javascriptreact" },
        root_dir = require("lspconfig.util").root_pattern(".graphqlrc", ".graphqlrc.yml", ".graphqlrc.yaml", ".graphqlrc.json", "graphql.config.js", "graphql.config.ts"),
      },
      eslint = {
        settings = {
          run = "onSave",
        },
      },
    },
  },
}
