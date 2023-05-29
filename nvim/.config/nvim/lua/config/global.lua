vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh', 'R=r' }
vim.opt.termguicolors = true

-- more opinionated
vim.opt.number = true -- show linenumbers
vim.opt.relativenumber = true
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.ruler = false                           -- hide the line and column number of the cursor position
vim.opt.numberwidth = 3                         -- minimal number of columns to use for the line number {default 4}
vim.opt.timeoutlen = 400 -- until which-key pops up
vim.opt.updatetime = 150 -- for autocommands and hovers
vim.opt.mouse = 'a' -- enable mouse
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard
vim.opt.backup = false                          -- creates a backup file
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.o.timeout = true
vim.opt.timeoutlen = 600                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 24                      -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

-- don't ask about existing swap files
vim.opt.shortmess:append 'A'

-- use spaces as tabs
local tabsize = 6
vim.opt.expandtab = true
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- consistent number column
vim.opt.signcolumn = "yes:1"

-- how to show autocomplete menu
vim.opt.completeopt = 'menuone,noinsert'

-- add folds with treesitter grammar
vim.opt.foldmethod = "expr"
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- but open all by default
vim.opt.foldlevel = 99

-- global statusline
vim.opt.laststatus = 3

-- split right and below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

--tabline
vim.opt.showtabline = 0

--windowline
-- vim.opt.winbar = '%t'

--don't continue comments automagically
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

-- hide cmdline when not used
vim.opt.cmdheight = 1


