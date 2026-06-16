# LazyVim Configuration Notes

## Configure Grep to Use Fixed Strings

To make the snacks picker grep (`<leader>/`) treat search patterns as literal strings instead of regex:

Edit `lua/plugins/snacks.lua` and add `args = { "--fixed-strings" }` to the grep source:

```lua
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
```

This allows searching for special characters like `{`, `[`, `.`, `*` without escaping them.
