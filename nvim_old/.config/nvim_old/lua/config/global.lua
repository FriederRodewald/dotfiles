vim.opt.termguicolors = true              -- Enable true color support if the terminal supports it.

-- More opinionated settings:
vim.opt.number = true                     -- Show line numbers.
vim.opt.relativenumber = true             -- Show relative line numbers.
vim.opt.cursorline = true                 -- Highlight the current line.
vim.opt.ruler = false                     -- Hide the line and column number of the cursor position.
vim.opt.numberwidth = 3                   -- Set the minimal number of columns to use for the line number.
vim.opt.mouse = 'a'                       -- Enable mouse support.
vim.opt.clipboard:append 'unnamedplus'    -- Use the system clipboard.
vim.opt.backup = false                    -- Disable creating backup files.
vim.opt.fileencoding = "utf-8"            -- Set the default file encoding to UTF-8.
vim.o.timeout = true                      -- Enable 'timeout' behavior (see below).
vim.opt.timeoutlen = 600                  -- Set the time to wait for a mapped sequence to complete (in milliseconds).
vim.opt.updatetime = 100                  -- Set the time to wait for autocommands and hovers.
vim.opt.undofile = true                   -- Enable persistent undo.
vim.opt.wrap = false                      -- Display lines as one long line.
vim.opt.scrolloff = 8                     -- Set the minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 24                -- Set the minimal number of screen columns to keep to the left and right of the cursor if wrap is false.

vim.opt.shortmess:append 'A'              -- Don't ask about existing swap files.

-- Use spaces instead of tabs:
local tabsize = 6
vim.opt.expandtab = true                  -- Use spaces instead of tabs for indentation.
vim.opt.shiftwidth = tabsize              -- Number of spaces for each level of indentation.
vim.opt.tabstop = tabsize                 -- Number of spaces that a <Tab> counts for.

-- Space as leader and local leader:
vim.g.mapleader = " "                     -- Set global leader key to space.
vim.g.maplocalleader = " "                -- Set local leader key to space.

-- Smarter search settings:
vim.opt.ignorecase = true                 -- Make searches case-insensitive by default.
vim.opt.smartcase = true                  -- Override 'ignorecase' when the search pattern contains uppercase characters.

-- Indent settings:
vim.opt.smartindent = true                -- Enable smart auto-indenting.
vim.opt.breakindent = true                -- Enable auto-indenting on wrapped lines.

-- Consistent number column:
vim.opt.signcolumn = "yes:1"              -- Always show the number column, even when there are no line numbers.

-- How to show autocomplete menu:
vim.opt.completeopt = 'menuone,noinsert'  -- Show a menu with possible completions, but do not automatically insert.

-- Add folds with treesitter grammar:
vim.opt.foldmethod = "expr"               -- Set foldmethod to expression.
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'  -- Use treesitter grammar for folding.
vim.opt.foldlevel = 99                    -- Open all folds by default.

-- Global statusline:
vim.opt.laststatus = 3                    -- Always show the statusline.

-- Split right and below by default:
vim.opt.splitright = true                 -- Open new split windows to the right by default.
vim.opt.splitbelow = true                 -- Open new split windows below by default.

-- Tabline settings:
vim.opt.showtabline = 0                   -- Hide the tabline.

-- Windowline settings:
-- vim.opt.winbar = '%f'                  -- Show file names in the window statusline.

-- Don't continue comments automagically:
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })  -- Disable auto-comment continuation, auto-wrap, and comment formatting.

-- Hide cmdline when not used:
vim.opt.cmdheight = 1            -- Set the command-line height to 1, hiding it when not in use.

