return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            format = { timeout_ms = 3000 },
            servers = {
                pyright = {},
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
