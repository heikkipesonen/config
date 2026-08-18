return {
  'saghen/blink.cmp',
  opts = {
    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
    sources = {
      providers = {
        css_vars = {
          name = 'css_vars',
          module = 'css-vars-source',
        },
      },
      per_filetype = {
        css = { 'css_vars', 'lsp', 'buffer' },
        scss = { 'css_vars', 'lsp', 'buffer' },
      },
    },
  },
}
