return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                dev = false,
                opts = {
                    buffers = {
                        set_filetype = true,
                        write_to_disk = false,
                    },
                    handle_leading_whitespace = true,
                },
            },
            "jmbuhr/cmp-pandoc-references",
            "R-nvim/cmp-r",
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
                { name = "pandoc_references" },
            }))
            opts.experimental = {
                ghost_text = false,
            }
        end,
    },
}
