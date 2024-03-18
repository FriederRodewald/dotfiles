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
  "<S-h>", -- top instead of bprev
  "<S-l>", -- lower instead of bnext
  "<leader>bb", -- switch to other buffer, using: <leader>`
  "<leader>wd", -- delete window, <C-W>c, now just quit
  "<leader>ww", -- other window, <C-W>p, not necessary
  "<leader>w-", -- duplicate split window <C-W>s
  "<leader>w|", -- duplicate split window <C-W>v
  "<leader>qq", -- quit all
}) do
  vim.keymap.del("n", key)
end

-- terminal mode
for _, key in pairs({
  "<c-h>", -- harpoon consistency
  "<c-j>",
  "<c-k>",
  "<c-l>",
  -- "esc esc" causes delay when using zsh vi mode:
  -- "esc c" is translated into "alt c" and invokes fzf directories
  "<esc><esc>",
}) do
  vim.keymap.del("t", key)
end

--------------------------------------------------------------------------
-- Change mappings
--------------------------------------------------------------------------

-- leader q now available:
map("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })
-- leader w now available. Lazy uses ctrl-s
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "[W]rite" })
