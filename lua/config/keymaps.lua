-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "å", "[", { noremap = true })
vim.keymap.set("n", "¨", "]", { noremap = true })
vim.keymap.set("n", "ä", "{", { noremap = true })
vim.keymap.set("n", "'", "}", { noremap = true })

vim.keymap.set("n", "<leader>fy", function()
  vim.fn.setreg("+", vim.fn.expand("%:."))
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>fY", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy absolute file path" })
