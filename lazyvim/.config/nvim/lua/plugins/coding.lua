return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- "R-nvim/cmp-r",
            "jmbuhr/cmp-pandoc-references",
            "jmbuhr/otter.nvim",
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            })
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
                { name = "otter" },
                { name = "cmp_r" },
            }))
        end,
    },
}
