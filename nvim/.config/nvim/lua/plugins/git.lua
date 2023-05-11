return {
      -- git and projects
      -- { 'ThePrimeagen/git-worktree.nvim' },
      -- { 'sindrets/diffview.nvim' },
      {
            'TimUntersberger/neogit',
            lazy = true,
            cmd = 'Neogit',
            config = function()
                  require('neogit').setup {
                        disable_commit_confirmation = true,
                        integrations = {
                              diffview = true
                        }
                  }
            end
      },
      {
            'lewis6991/gitsigns.nvim',
            config = function()
                  require('gitsigns').setup {
                        signs = {
                              add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                              change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr",
                                    linehl = "GitSignsChangeLn" },
                              delete = { hl = "GitSignsDelete", text = "▶", numhl = "GitSignsDeleteNr",
                                    linehl = "GitSignsDeleteLn" },
                              topdelete = { hl = "GitSignsDelete", text = "▶", numhl = "GitSignsDeleteNr",
                                    linehl = "GitSignsDeleteLn" },
                              changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr",
                                    linehl = "GitSignsChangeLn" },
                        },
                        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                        watch_gitdir = {
                              interval = 1000,
                              follow_files = true,
                        },
                        attach_to_untracked = true,
                        current_line_blame_opts = {
                              virt_text = true,
                              virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                              delay = 1000,
                        },
                        sign_priority = 6,
                        update_debounce = 100,
                        status_formatter = nil, -- Use default
                        preview_config = {
                              -- Options passed to nvim_open_win
                              border = "single",
                              style = "minimal",
                              relative = "cursor",
                              row = 0,
                              col = 1,
                        },
                  }
            end
      },
      {
            'akinsho/git-conflict.nvim',
            config = function()
                  require('git-conflict').setup {
                        default_mappings = true,
                        disable_diagnostics = true,
                  }
            end
      },
      { 'f-person/git-blame.nvim' },
      -- github PRs and the like with gh-cli
      -- { 'pwntester/octo.nvim', config = function()
      --   require "octo".setup()
      -- end },
}
