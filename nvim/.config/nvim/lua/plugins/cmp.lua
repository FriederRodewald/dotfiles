return {
      -- completion
      {
            'hrsh7th/nvim-cmp',
            dependencies = {
                  { 'hrsh7th/cmp-nvim-lsp' },
                  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
                  { 'hrsh7th/cmp-buffer' },
                  { 'hrsh7th/cmp-path' },
                  { 'hrsh7th/cmp-calc' },
                  { 'hrsh7th/cmp-emoji' },
                  { 'saadparwaiz1/cmp_luasnip' },
                  { 'f3fora/cmp-spell' },
                  { 'ray-x/cmp-treesitter' },
                  { 'kdheepak/cmp-latex-symbols' },
                  { 'jmbuhr/cmp-pandoc-references' },
                  { 'L3MON4D3/LuaSnip' },
                  { 'rafamadriz/friendly-snippets' },

                  -- optional
                  -- more things to try:
                  -- {
                  --   "zbirenbaum/copilot-cmp",
                  --   after = { "copilot.lua" },
                  --   dependencies = { "zbirenbaum/copilot.lua" },
                  --   config = function()
                  --     require("copilot").setup({
                  --       suggestion = { enabled = false },
                  --       panel = { enabled = false },
                  --     })
                  --     require("copilot_cmp").setup()
                  --   end
                  -- },

            },
            config = function()
                  local cmp = require 'cmp'
                  local luasnip = require 'luasnip'

                  local has_words_before = function()
                        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                        return col ~= 0 and
                            vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                  end

                  local check_backspace = function()
                        local col = vim.fn.col "." - 1
                        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
                  end

                  local kind_icons = {
                        Text = "",
                        Method = "",
                        Function = "",
                        Constructor = "",
                        Field = "",
                        Variable = "",
                        Class = "",
                        Interface = "",
                        Module = "",
                        Property = "",
                        Unit = "",
                        Value = "",
                        Enum = "",
                        Keyword = "",
                        Snippet = "",
                        Color = "",
                        File = "",
                        Reference = "",
                        Folder = "",
                        EnumMember = "",
                        Constant = "",
                        Struct = "",
                        Event = "",
                        Operator = "",
                        TypeParameter = "",
                  }

                  cmp.setup({
                        snippet = {
                              expand = function(args)
                                    luasnip.lsp_expand(args.body)
                              end,
                        },
                        mapping = cmp.mapping.preset.insert {
                              ["<C-k>"] = cmp.mapping.select_prev_item(),
                              ["<C-j>"] = cmp.mapping.select_next_item(),
                              ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                              ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                              ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                              ["<C-e>"] = cmp.mapping {
                                    i = cmp.mapping.abort(),
                                    c = cmp.mapping.close(),
                              },
                              ['<CR>'] = cmp.mapping.confirm({
                                    select = false,
                              }),
                              ["<Tab>"] = cmp.mapping(function(fallback)
                                    if cmp.visible() then
                                          cmp.select_next_item()
                                    elseif has_words_before() then
                                          cmp.complete()
                                    elseif luasnip.expandable() then
                                          luasnip.expand()
                                    elseif luasnip.expand_or_jumpable() then
                                          luasnip.expand_or_jump()
                                    elseif check_backspace() then
                                          fallback()
                                    else
                                          fallback()
                                    end
                              end, { "i", "s" }),
                              ["<S-Tab>"] = cmp.mapping(function(fallback)
                                    if cmp.visible() then
                                          cmp.select_prev_item()
                                    elseif luasnip.jumpable(-1) then
                                          luasnip.jump(-1)
                                    else
                                          fallback()
                                    end
                              end, { "i", "s" }),
                        },
                        autocomplete = false,
                        formatting = {
                              fields = { 'kind', 'abbr', 'menu' },
                              format = function(entry, vim_item)
                                    vim_item.kind = kind_icons[vim_item.kind]
                                    vim_item.menu = ({
                                          otter = "",
                                          path = "",
                                          nvim_lsp = "",
                                          nvim_lsp_signature_help = "",
                                          luasnip = "",
                                          pandoc_references = "",
                                          buffer = "",
                                          spell = "",
                                          treesitter = "",
                                          calc = "",
                                          latex_symbols = "",
                                          emoji = "",
                                    })[entry.source.name]
                                    return vim_item
                              end,
                        },
                        sources = {
                              -- { name = 'copilot',                keyword_length = 0, max_item_count = 3 },
                              { name = 'otter' }, -- for code chunks in quarto
                              { name = 'path' },
                              { name = 'nvim_lsp' },
                              { name = 'nvim_lsp_signature_help' },
                              { name = 'luasnip', keyword_length = 3, max_item_count = 3 },
                              { name = 'pandoc_references' },
                              { name = 'buffer', keyword_length = 5, max_item_count = 3 },
                              { name = 'spell' },
                              { name = 'treesitter', keyword_length = 5, max_item_count = 3 },
                              { name = 'calc' },
                              { name = 'latex_symbols' },
                              { name = 'emoji' },
                        },
                        confirm_opts = {
                              behavior = cmp.ConfirmBehavior.Replace,
                              select = false,
                        },
                        window = {
                              completion = cmp.config.window.bordered(),
                              documentation = cmp.config.window.bordered(),
                        },
                        experimental = {
                              ghost_text = true,
                        },
                  })
                  -- for friendly snippets
                  require("luasnip.loaders.from_vscode").lazy_load()
                  -- for custom snippets
                  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snips" } })
            end
      },
}
