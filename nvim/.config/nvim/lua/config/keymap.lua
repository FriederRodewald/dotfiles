local wk = require("which-key")

-- Define key mappings for normal, visual, and insert modes.
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

-- Resize window using <Ctrl> + arrow keys.
nmap("<C-Up>", "<cmd>resize +1<CR>")
nmap("<C-Down>", "<cmd>resize -3<CR>")
nmap("<C-Left>", "<cmd>vertical resize -3<CR>")
nmap("<C-Right>", "<cmd>vertical resize +1<CR>")

-- Center after search and jumps.
nmap('n', "nzz")
nmap('<c-d>', '<c-d>zz')
nmap('<c-u>', '<c-u>zz')

-- Press 'jk' fast to enter normal mode.
imap("jk", "<ESC>")

-- Move between splits and tabs.
nmap('<s-h>', '<cmd>bprevious<cr>')
nmap('<s-l>', '<cmd>bnext<cr>')

-- miscellaneous mappings
nmap('U', '<c-r>') -- remap redo
nmap('<leader>x', ':Bdelete<cr>') -- close the current buffer tab

--- Specific to Language ---

-- Send code with Ctrl+Enter just like in RStudio.
nmap('<c-cr>', '<Plug>SlimeParagraphSend')
nmap('<s-cr>', '<cmd>SlimeSendCurrentLine<cr><Down>')
imap('<c-cr>', '<esc><Plug>SlimeParagraphSend')
imap('<s-cr>', '<esc><cmd>SlimeSendCurrentLine<cr><Down>i')
vmap('<cr>', '<Plug>SlimeRegionSend')


--- WhickKey Register ---

--show kepbindings with whichkey

-- which-key configuration for defining and displaying key mappings
wk.register(
      {
            -- Leader key mappings for vim maintainance
            v = {
                  name = 'vim',
                  l = { ':Lazy<cr>', 'Lazy' },
                  m = { ':Mason<cr>', 'Mason' },
                  s = { ':e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>', 'Settings' },
                  h = { ':execute "h " . expand("<cword>")<cr>', 'help' }
            },

            -- Leader key mappings for language-related actions
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
                  t    = { ':TroubleToggle<cr>', 'toggle trouble' },
            },

            -- Leader key mappings for Quarto-related actions
            q = {
                  name = 'quarto',
                  p = { ":lua require'quarto'.quartoPreview()<cr>", 'preview' },
                  q = { ":lua require'quarto'.quartoClosePreview()<cr>", 'close' },
                  h = { ":QuartoHelp ", 'help' },
            },

            -- Leader key mappings for finding actions using Telescope
            f = {
                  name = 'find (telescope)',
                  f = { '<cmd>Telescope find_files<cr>', 'files' },
                  t = { '<cmd>Telescope file_browser<cr>', 'tree/browser' },
                  h = { '<cmd>Telescope help_tags<cr>', 'help' },
                  k = { '<cmd>Telescope keymaps<cr>', 'keymaps' },
                  g = { "<cmd>Telescope live_grep<cr>", "grep" },
                  b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "fuzzy" },
                  m = { "<cmd>Telescope marks<cr>", "marks" },
                  M = { "<cmd>Telescope man_pages<cr>", "man pages" },
                  c = { "<cmd>Telescope git_commits<cr>", "git commits" },
                  q = { "<cmd>Telescope quickfix<cr>", "quickfix" },
                  l = { "<cmd>Telescope loclist<cr>", "loclist" },
                  j = { "<cmd>Telescope jumplist<cr>", "marks" },
            },

            -- Leader key mappings for navigating using LSP and Telescope
            n = {
                  name = 'navigate (lsp/telescope)',
                  s = { "<cmd>Telescope lsp_document_symbols<cr>", "symbols" },
                  r = { '<cmd>Telescope lsp_references<cr>', 'references' },
                  t = { '<cmd>Telescope lsp_type_definitions<cr>', 'type definitions' },
                  d = { '<cmd>Telescope lsp_definitions<cr>', 'definitions' },
                  S = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'signature help' },
                  i = { '<cmd>Telescope lsp_implementations<cr>', 'implementations' },
                  R = { '<cmd>Telescope lsp_references<cr>', 'references' },
            },

            -- Leader key mappings for spellchecking
            s = {
                  name = "spellcheck",
                  s = { "<cmd>Telescope spell_suggest<cr>", "spelling" },
                  ['/'] = { '<cmd>setlocal spell!<cr>', 'spellcheck' },
                  n = { ']s', 'next' },
                  p = { '[s', 'previous' },
                  r = { 'zg', 'right' },
                  w = { 'zw', 'wrong' },
            },

            -- Leader key mappings for Git-related actions
            g = { ":LazyGit<cr>", "lazygit" },

            -- Leader key mappings for doing something
            d = {
                  name = "do something",
                  r = { 'o```{r}<cr><cr><cr><cr>```<esc>kk', 'insert R code chunk' },
                  p = { 'o```{python}<cr><cr><cr><cr>```<esc>kk', 'insert Python code chunk' },
            },

            -- Leader key mappings for hiding search highlighting
            h = { '<cmd>noh<cr>', 'remove search' },

            -- Leader key mappings for commenting/uncommenting
            c = { '<cmd>:normal gcc<cr>', '(un)comment' },
      },

      -- Specify normal mode and leader key
      { mode = {'n', 'v'}, prefix = '<leader>' } 
)
