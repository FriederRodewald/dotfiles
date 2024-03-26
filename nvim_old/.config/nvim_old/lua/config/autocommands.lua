-- ensure that the buffer reflects the latest changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = { "*" },
  command = "checktime",
}
)

-- sets up a key mapping for closing the buffer and ensures that the buffer is not listed in the buffer list
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- highlight visually selected text for a brief duration after a yank operation 
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

