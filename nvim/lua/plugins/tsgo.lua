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
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "none", suppressWhenArgumentMatchesName = true },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = false },
            },
          },
        },
      },
      cssmodules_ls = {
        filetypes = { "typescriptreact", "javascriptreact" },
        init_options = {
          camelCase = false,
        },
      },
      graphql = {
        filetypes = { "graphql", "typescript", "typescriptreact", "javascriptreact" },
      },
      eslint = {
        settings = {
          run = "onSave",
        },
      },
    },
  },
}
