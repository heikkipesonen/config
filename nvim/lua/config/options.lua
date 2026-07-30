-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Performance fixes for smooth scrolling
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 200
vim.opt.cursorline = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.redrawtime = 10000

-- Disable inlay hints globally and on every LSP attach
vim.lsp.inlay_hint.enable(false)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
  end,
})
