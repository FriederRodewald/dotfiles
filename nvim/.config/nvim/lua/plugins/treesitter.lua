return {
      {
            'nvim-treesitter/nvim-treesitter',
            tag = nil,
            branch = 'master',
            run = ':TSUpdate',
            config = function()
                  require 'nvim-treesitter.configs'.setup {
                        ensure_installed = {
                              'r', 'python', 'markdown', 'markdown_inline',
                              'julia', 'bash', 'yaml', 'lua', 'vim',
                              'query', 'vimdoc', 'latex', 'html', 'css'
                        },
                        highlight = {
                              enable = true,
                              additional_vim_regex_highlighting = { 'markdown' },
                        },
                        indent = {
                              enable = true,
                        },
                        incremental_selection = {
                              enable = true,
                              keymaps = {
                                    init_selection = "gnn",
                                    node_incremental = "grn",
                                    scope_incremental = "grc",
                                    node_decremental = "grm",
                              },
                        },
                  }
            end
      },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
}
