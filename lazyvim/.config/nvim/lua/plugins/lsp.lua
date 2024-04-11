return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            format = { timeout_ms = 3000 },
            servers = {
                pyright = {},
                r_language_server = {
                    mason = false,
                    settings = {
                        r = {
                            lsp = {
                                rich_documentation = false,
                            },
                        },
                    },
                },
                marksman = {
                    -- also needs: ~/.config/marksman/config.toml:
                    -- [core]
                    -- markdown.file_extensions = ["md", "markdown", "qmd"]
                    filetypes = { "markdown", "quarto" },
                    root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
                },
            },
            setup = {
                volar = function()
                    require("lazyvim.util").lsp.on_attach(function(client, _)
                        if client.name == "volar" then
                            client.server_capabilities.documentFormattingProvider = false
                        end
                    end)
                end,
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
