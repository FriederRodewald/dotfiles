return {

    { "R-nvim/R.nvim" },

    { "R-nvim/cmp-r" },

    {
        "quarto-dev/quarto-nvim",
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "html", "lua" },
            },
        },
        ft = "quarto",
        keys = {
            { "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "Quarto Preview" },
            { "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "Quarto Close" },
            { "<leader>qh", ":QuartoHelp ", desc = "Quarto Help" },
            { "<leader>qe", ":lua require'otter'.export()<cr>", desc = "Quarto Export" },
            { "<leader>qrr", ":QuartoSendAbove<cr>", desc = "Quarto Run to Cursor" },
            { "<leader>qra", ":QuartoSendAll<cr>", desc = "Quarto Run All" },
            { "<c-cr>", ":SlimeSend<cr>", desc = "Send Code Chunk" },
            { "<c-cr>", "<esc>:SlimeSend<cr>i", mode = "i", desc = "Send Code Chunk" },
            { "<c-cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "Send Code Chunk" },
            { "<cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "Send Code Chunk" },
        },
    },

    {
        "jmbuhr/otter.nvim",
        opts = {
            buffers = {
                set_filetype = true,
            },
        },
    },

    {
        "jpalardy/vim-slime",
        init = function()
            vim.b["quarto_is_" .. "python" .. "_chunk"] = false
            Quarto_is_in_python_chunk = function()
                require("otter.tools.functions").is_otter_language_context("python")
            end

            vim.cmd([[
                    let g:slime_dispatch_ipython_pause = 100
                    function SlimeOverride_EscapeText_quarto(text)
                        call v:lua.Quarto_is_in_python_chunk()
                        if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
                            return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
                        else
                            return a:text
                        end
                    endfunction
                    ]])

            -- slime, tmux
            vim.g.slime_target = "tmux"
            vim.g.slime_bracketed_paste = 1
            vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }
        end,
    },

    {
        "lukas-reineke/headlines.nvim",
        opts = function()
            local opts = {}
            for _, ft in ipairs({ "quarto", "markdown", "rmd" }) do
                opts[ft] = {
                    headline_highlights = {},
                    -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
                    bullets = {},
                    --         query = vim.treesitter.parse_query(
                    --             "markdown",
                    --             [[
                    --     (atx_heading [
                    --         (atx_h1_marker)
                    --         (atx_h2_marker)
                    --         (atx_h3_marker)
                    --         (atx_h4_marker)
                    --         (atx_h5_marker)
                    --         (atx_h6_marker)
                    --     ] @headline)
                    --
                    --     (thematic_break) @dash
                    --
                    --     (fenced_code_block) @codeblock
                    --
                    --     (block_quote_marker) @quote
                    --     (block_quote (paragraph (inline (block_continuation) @quote)))
                    --     (block_quote (paragraph (block_continuation) @quote))
                    --     (block_quote (block_continuation) @quote)
                    -- ]]
                    --         ),
                    codeblock_highlight = "CodeBlock",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = true,
                    fat_headline_upper_string = "▃",
                    fat_headline_lower_string = "_",
                }
                for i = 1, 6 do
                    local hl = "Headline" .. i
                    vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
                    table.insert(opts[ft].headline_highlights, hl)
                end
            end
            return opts
        end,
        ft = { "qmd", "markdown", "rmd" },
        config = function(_, opts)
            -- PERF: schedule to prevent headlines slowing down opening a file
            vim.schedule(function()
                require("headlines").setup(opts)
                require("headlines").refresh()
            end)
        end,
    },
}
