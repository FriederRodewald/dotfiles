local wk = require("which-key")

P = function(x)
      print(vim.inspect(x))
      return (x)
end

RELOAD = function(...)
      return require 'plenary.reload'.reload_module(...)
end

R = function(name)
      RELOAD(name)
      return require(name)
end

local nmap = function(key, effect)
      vim.keymap.set('n', key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
      vim.keymap.set('v', key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
      vim.keymap.set('i', key, effect, { silent = true, noremap = true })
end

--- Basic Shortcuts ---

-- resize window using <ctrl> arrow keys
nmap("<C-Up>", "<cmd>resize +1<CR>")
nmap("<C-Down>", "<cmd>resize -3<CR>")
nmap("<C-Left>", "<cmd>vertical resize -3<CR>")
nmap("<C-Right>", "<cmd>vertical resize +1<CR>")

-- center after search and jumps
nmap('n', "nzz")
nmap('<c-d>', '<c-d>zz')
nmap('<c-u>', '<c-u>zz')

-- Press jk fast to enter
imap("jk", "<ESC>")

-- move between splits and tabs
nmap('<s-h>', '<cmd>bprevious<cr>')
nmap('<s-l>', '<cmd>bnext<cr>')

--- Specific to Language ---

-- send code with ctrl+Enter just like in e.g. RStudio
-- needs terminal config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap('<c-cr>', '<Plug>SlimeParagraphSend')
nmap('<s-cr>', '<cmd>SlimeSendCurrentLine<cr><Down>')
imap('<c-cr>', '<esc><Plug>SlimeParagraphSend')
imap('<s-cr>', '<esc><cmd>SlimeSendCurrentLine<cr><Down>i')
vmap('<cr>', '<Plug>SlimeRegionSend')

imap('<m-a>', ' <- ') -- assign operator
imap('<m-p>', ' |> ') -- pipe operator

nmap('n', 'nzzzv') -- center search
nmap('gN', 'Nzzzv') -- center search
nmap('cor', 'o```{r}<cr>```<esc>O') -- insert R code chunk
nmap('cor', 'o```{python}<cr>```<esc>O') -- insert Python code chunk

--show kepbindings with whichkey
wk.register(
      {
            v = {
                  name = 'vim',
                  l = { ':Lazy<cr>', 'Lazy' },
                  m = { ':Mason<cr>', 'Mason' },
                  s = { ':e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>', 'Settings' },
                  h = { ':execute "h " . expand("<cword>")<cr>', 'help' }
            },
            l = {
                  name = 'language/lsp',
                  i    = { vim.diagnostic.open_float, 'diagnostics info' },
                  f    = { vim.lsp.buf.format, 'format' },
                  o    = { ':SymbolsOutline<cr>', 'outline overview' },
                  d    = {
                        name = 'toggle diagnostics',
                        d = { vim.diagnostic.disable, 'disable' },
                        e = { vim.diagnostic.enable, 'enable' },
                  },
                  c    = {
                        name = 'toggle cmp',
                        d = { ':lua require(\'cmp\').setup.buffer { enabled = false }<cr>',
                              'disable cmp for current buffer' },
                        e = { ':lua require(\'cmp\').setup.buffer { enabled = true }<cr>',
                              'enable cmp for current buffer' },
                  },
            },
            q = {
                  name = 'quarto',
                  p = { ":lua require'quarto'.quartoPreview()<cr>", 'preview' },
                  q = { ":lua require'quarto'.quartoClosePreview()<cr>", 'close' },
                  h = { ":QuartoHelp ", 'help' },
            },
            f = {
                  name = 'find (telescope)',
                  f = { '<cmd>Telescope find_files<cr>', 'files' },
                  h = { '<cmd>Telescope help_tags<cr>', 'help' },
                  k = { '<cmd>Telescope keymaps<cr>', 'keymaps' },
                  r = { '<cmd>Telescope lsp_references<cr>', 'references' },
                  g = { "<cmd>Telescope live_grep<cr>", "grep" },
                  b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy" },
                  m = { "<cmd>Telescope marks<cr>", "marks" },
                  M = { "<cmd>Telescope man_pages<cr>", "man pages" },
                  c = { "<cmd>Telescope git_commits<cr>", "git commits" },
                  s = { "<cmd>Telescope lsp_document_symbols<cr>", "symbols" },
                  d = { "<cmd>Telescope buffers<cr>", "buffers" },
                  q = { "<cmd>Telescope quickfix<cr>", "quickfix" },
                  l = { "<cmd>Telescope loclist<cr>", "loclist" },
                  j = { "<cmd>Telescope jumplist<cr>", "marks" },
            },
            s = {
                  name = "spellcheck",
                  s = { "<cmd>Telescope spell_suggest<cr>", "spelling" },
                  ['/'] = { '<cmd>setlocal spell!<cr>', 'spellcheck' },
                  n = { ']s', 'next' },
                  p = { '[s', 'previous' },
                  r = { 'zg', 'rigth' },
                  w = { 'zw', 'wrong' },
            },
            g = {
                  name = "git",
                  g = { ":Neogit<cr>", "neogit" },
                  d = {
                        name = 'diff',
                        o = { ':DiffviewOpen<cr>', 'open' },
                        c = { ':DiffviewClose<cr>', 'close' },
                  }
            },
            h = { '<cmd>noh<cr>', 'rm search' },
            x = { ':w<cr>:source %<cr>', 'source file' },
            c = { '<cmd>:normal gcc<cr>', '(un)comment' },
      }, { mode = 'n', prefix = '<leader>' }
)
