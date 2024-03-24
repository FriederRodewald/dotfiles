-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.scrolloff = 8 -- Set the minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 24 -- Set the minimal number of screen columns to keep to the left and right of the cursor if wrap is false.
vim.opt.timeoutlen = 700 -- Set the time to wait for a mapped sequence to complete (in milliseconds).

vim.g.input_suggestion = true -- Input Sugesstion (toggle with "<leader>u<tab>")

-- highlight (currently not working)
-- vim.cmd([[highlight Headline1 guibg=#FF0000]])
-- vim.cmd([[highlight Headline2 guibg=#00FF00]])
-- vim.cmd([[highlight Headline3 guibg=#0000FF]])
-- vim.cmd([[highlight CodeBlock guibg=#000000]])
-- vim.cmd([[highlight Dash guibg=#FF0000 gui=bold]])
