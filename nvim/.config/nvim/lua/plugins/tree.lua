return {
      -- filetree
{
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<leader>e', ':NvimTreeToggle<cr>' },
    },
    config = function()
      require 'nvim-tree'.setup {
        disable_netrw       = true,
        update_focused_file = {
          enable = true,
        },
        git                 = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        diagnostics         = {
          enable = true,
        },
      }
    end
  },}
