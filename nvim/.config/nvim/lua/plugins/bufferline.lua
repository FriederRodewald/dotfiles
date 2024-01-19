local M = {
      "akinsho/bufferline.nvim",
      dependencies = {
            {
                  "famiu/bufdelete.nvim",
            },
      },
}

M.opts = {
      options = {
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
            separator_style = "thin",    -- | "thick" | "thin" | { 'any', 'any' },
            show_buffer_close_icons = false,
      },
}

return M
