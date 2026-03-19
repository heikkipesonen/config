return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ts_ls = {
        settings = {
          typescript = {
            suggest = {
              completeFunctionCalls = true,
            },
          },
        },
        init_options = {
          plugins = {
            {
              name = "@web/dev-server-esbuild",
              location = "",
            },
          },
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Disable semantic tokens for better performance
    client.server_capabilities.semanticTokensProvider = nil
    -- Disable document highlights
    client.server_capabilities.documentHighlightProvider = false
    -- Disable codelens
    client.server_capabilities.codeLensProvider = nil
  end,
}
