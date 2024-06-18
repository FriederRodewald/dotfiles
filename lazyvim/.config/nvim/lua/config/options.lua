-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.maplocalleader = " " -- Set localleader to SPACE

vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.scrolloff = 8 -- Set the minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 24 -- Set the minimal number of screen columns to keep to the left and right of the cursor if wrap is false.
vim.opt.timeoutlen = 700 -- Set the time to wait for a mapped sequence to complete (in milliseconds).

vim.opt.conceallevel = 0 -- don't conceal code blocks in quarto

vim.g.input_suggestion = true -- input sugesstion (toggle with "<leader>u<tab>")

vim.opt.showtabline = 0 -- don't show tabline
