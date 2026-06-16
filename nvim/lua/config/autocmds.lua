-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
  end,
})

-- Disable concealment for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
-- Cleaner diagnostic display
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
    source = true,
    max_width = 80,
  },
})

-- ESLint fix all on save (import sorting, unused imports, etc.)
-- Uses LspEslintFixAll (new nvim-lspconfig) which is synchronous (request_sync)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    if vim.fn.exists(":LspEslintFixAll") > 0 then
      vim.cmd("LspEslintFixAll")
    elseif vim.fn.exists(":EslintFixAll") > 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- Show diagnostic float on hover
vim.o.updatetime = 250
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
