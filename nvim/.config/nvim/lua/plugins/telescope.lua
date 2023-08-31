return {
      -- telescope
      -- a nice seletion UI also to find and open files
      {
            'nvim-telescope/telescope.nvim',
            config = function()
                  local telescope = require 'telescope'
                  local actions = require('telescope.actions')
                  local previewers = require("telescope.previewers")
                  local new_maker = function(filepath, bufnr, opts)
                        opts = opts or {}
                        filepath = vim.fn.expand(filepath)
                        vim.loop.fs_stat(filepath, function(_, stat)
                              if not stat then return end
                              if stat.size > 100000 then
                                    return
                              else
                                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                              end
                        end)
                  end
                  telescope.setup {
                        defaults = {
                              buffer_previewer_maker = new_maker,
                              file_ignore_patterns = { "node_modules", "%_files/*.html", "%_cache", ".git/", "site_libs",
                                    ".venv" },
                              layout_strategy = "flex",
                              sorting_strategy = "ascending",
                              layout_config = {
                                    prompt_position = "bottom",
                              },
                              mappings = {
                                    i = {
                                          ['<C-u>'] = false,
                                          ['<C-d>'] = false,
                                          ["<esc>"] = actions.close,
                                          ["<c-j>"] = actions.move_selection_next,
                                          ["<c-k>"] = actions.move_selection_previous,
                                    }
                              }
                        },
                        pickers = {
                              find_files = {
                                    hidden = true,
                                    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*",
                                          '--glob', '!**/.Rproj.user/*', '-L' },
                              }
                        },
                        extensions = {
                              ["ui-select"] = {
                                    require("telescope.themes").get_dropdown(),
                              },
                        }
                  }
                  telescope.load_extension('ui-select')
                  telescope.load_extension('fzf')
                  telescope.load_extension('ui-select')
                  telescope.load_extension('file_browser')
                  telescope.load_extension('dap')
            end
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
}
