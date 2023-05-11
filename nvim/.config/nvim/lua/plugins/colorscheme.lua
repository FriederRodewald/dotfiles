local M = {
      "folke/tokyonight.nvim",
      commit = "df13e32",
      lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "tokyonight-night"
function M.config()
      require("tokyonight").setup({
            on_colors = function(colors)
                  colors.border = "#000000"
            end
      })
      local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
      if not status_ok then
            return
      end
end

return M
