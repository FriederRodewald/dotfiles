return {
    {
        "folke/tokyonight.nvim",
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
            on_colors = function(colors)
                colors.bg_statusline = colors.none -- make lualine transparent
            end,
        },
    },

    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = {
            extra_groups = {
                "FloatBorder",
                "LSPInfoBorder",
                "NeoTreeNormal",
                "NeoTreeNormalNC",
                "NormalFloat",
                "NotifyDEBUGBody",
                "NotifyDEBUGBorder",
                "NotifyERRORBody",
                "NotifyERRORBorder",
                "NotifyINFOBody",
                "NotifyINFOBorder",
                "NotifyTRACEBody",
                "NotifyTRACEBorder",
                "NotifyWARNBody",
                "NotifyWARNBorder",
                "TelescopeBorder",
                "TelescopePreviewNormal",
                "TelescopePromptNormal",
                "TelescopeResultsNormal",
                "WhichKeyFloat",
            },
            exclude_groups = {
                "CursorLine",
            },
        },

        keys = {
            {
                "<leader>ux",
                "<Cmd>TransparentToggle<Cr>",
                desc = "Toggle Transparency",
            },
        },
    },
}
