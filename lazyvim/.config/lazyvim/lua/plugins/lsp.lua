return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
                r_language_server = {},
                marksman = {
                    -- also needs: ~/.config/marksman/config.toml:
                    -- [core]
                    -- markdown.file_extensions = ["md", "markdown", "qmd"]
                    filetypes = { "markdown", "quarto" },
                    root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
                },
            },
        },
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
            },
        },
    },
}
