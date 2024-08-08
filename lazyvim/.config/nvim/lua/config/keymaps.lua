-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
        opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
end

--------------------------------------------------------------------------
-- Delete mappings: b, w and q menus available
--------------------------------------------------------------------------

-- all modes
for _, mode in pairs({ "i", "x", "n", "s" }) do
    vim.keymap.del(mode, "<C-s>") -- save file in all modes
end

-- normal mode
for _, key in pairs({
    "<S-h>", -- prevBuffer
    "<S-l>", -- nextBuffer
    "[b", -- prevBuffer
    "]b", -- nextBuffer
    "<leader>bb", -- Switch to Other Buffer
    "<leader>`", -- Switch to Other Buffer
    "<leader>ur", -- Clear search, diff update and redraw
    "<leader>K", -- keywordprg
    "<leader>l", -- Lazy
    "<leader>xl", -- Location List
    "<leader>xq", -- Quickfix List
    "[q", -- Previous Quickfix
    "]q", -- Next Quickfix
    "<leader>qq", -- quit
    "<c-/>", -- floating terminal
    "<c-_>", -- floating terminal
    -- "<leader>ww", -- windows
    -- "<leader>wd",
    -- "<leader>w-",
    -- "<leader>w|",
    "<leader>-",
    "<leader>|",
    "<leader><tab>l", --tabs
    "<leader><tab>f",
    "<leader><tab><tab>",
    "<leader><tab>]",
    "<leader><tab>d",
    "<leader><tab>[",
}) do
    vim.keymap.del("n", key)
end

-- insert mode
for _, key in pairs({
    ".", -- undo break-points
    ",",
    ";",
}) do
    vim.keymap.del("i", key)
end

-- terminal mode
for _, key in pairs({
    "<C-h>", -- terminal mappings
    "<C-j>",
    "<C-k>",
    "<C-l>",
    "<C-/>",
    "<c-_>",
}) do
    vim.keymap.del("t", key)
end

--------------------------------------------------------------------------
-- Change mappings
--------------------------------------------------------------------------

-- move lines
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- close file
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- write file
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "[W]rite" })

--------------------------------------------------------------------------
-- Add mappings
--------------------------------------------------------------------------

-- remap undo
map({ "n", "v" }, "U", "<C-r>", { desc = "[U]ndo" })

-- add shortcut for pipe and assign operator in R
map("i", "<A-p>", "|>", { desc = "[P]ipe" })
map("i", "<A-a>", "<-", { desc = "[A]ssign" })

-- toggle input suggestion
local Util = require("lazyvim.util")

map("n", "<leader>u<tab>", function()
    vim.g.input_suggestion = vim.g.input_suggestion == false
    if vim.g.input_suggestion then
        Util.warn("Enabled Input Suggestion", { title = "Input Suggestion (buffer)" })
    else
        Util.info("Disabled Input Suggestion", { title = "Input Suggestion (buffer)" })
    end
    require("cmp").setup.buffer({
        enabled = function()
            if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                return false
            else
                return vim.g.input_suggestion
            end
        end,
    })
end, { desc = "Toggle Input Suggestion" })
