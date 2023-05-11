return {
     {
            'nvim-lualine/lualine.nvim',
            dependencies = {
                  { 'f-person/git-blame.nvim' },
            },
            config = function()
                  local git_blame = require('gitblame')
                  vim.g.gitblame_display_virtual_text = 0
                  vim.o.shortmess = vim.o.shortmess ..
                      "S" -- this is for the search_count function so lua can know this is `lua expression`
                  --function for optimizing the search count
                  local function search_count()
                        if vim.api.nvim_get_vvar("hlsearch") == 1 then
                              local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })

                              if res.total > 0 then
                                    return string.format("%d/%d", res.current, res.total)
                              end
                        end

                        return ""
                  end
                  local function macro_reg()
                        return vim.fn.reg_recording()
                  end
                  local hide_in_width = function()
                        return vim.fn.winwidth(0) > 80
                  end

                  local diagnostics = {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        sections = { "error", "warn" },
                        symbols = { error = " ", warn = " " },
                        colored = false,
                        always_visible = true,
                  }

                  local diff = {
                        "diff",
                        colored = false,
                        symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
                        cond = hide_in_width,
                  }

                  local filetype = {
                        "filetype",
                        icons_enabled = false,
                  }

                  local location = {
                        "location",
                        padding = 0,
                  }

                  local spaces = function()
                        return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
                  end
                  require('lualine').setup {
                        options = {
                              globalstatus = true,
                              icons_enabled = true,
                              theme = "auto",
                              component_separators = { left = "", right = "" },
                              section_separators = { left = "", right = "" },
                              disabled_filetypes = { "alpha", "dashboard" },
                              always_divide_middle = true,
                        },
                        sections = {
                              lualine_a = { 'mode', { macro_reg, type = 'lua_expr', color = 'WarningMsg' } },
                              lualine_b = { 'branch', { search_count, type = 'lua_expr' } },
                              lualine_c = { diagnostics },
                              lualine_x = { diff, spaces, "encoding", filetype },
                              lualine_y = { location },
                              lualine_z = { "progress" },
                        },
                        extensions = { 'nvim-tree' },
                  }
            end
      },
}
