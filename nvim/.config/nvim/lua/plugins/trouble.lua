return {
     -- show diagnostics list
      {
            "folke/trouble.nvim",
            config = function()
                  require("trouble").setup {}
            end
      },
}
