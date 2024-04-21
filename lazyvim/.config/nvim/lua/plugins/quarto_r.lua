vim.cmd([[
let g:slime_cell_delimiter = "^```{\?\a\+}\?$"
let g:slime_preserve_curpos = 1
let g:slime_dont_ask_default = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": ".2"}

" highlight CodeBlock guibg=red
]])

return {

    {
        "R-nvim/R.nvim",
        opts = {
            active_window_warn = false,
        },
    },

    {
        "quarto-dev/quarto-nvim",
        dev = false,
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
            },
            codeRunner = {
                enabled = true,
                default_method = "slime",
            },
            keymap = {
                -- set whole section or individual keys to `false` to disable
                hover = "K",
                definition = "gd",
                type_definition = "gD",
                rename = "<leader>cr",
                format = "<leader>cf",
                references = "gr",
                document_symbols = "<leader>ss",
            },
        },
        ft = "quarto",
        keys = {
            { "<leader>cqp", ":lua require'quarto'.quartoPreview()<cr>", desc = "Quarto Preview" },
            { "<leader>cqq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "Quarto Close" },
            { "<leader>cqh", ":QuartoHelp ", desc = "Quarto Help" },
            { "<leader>cqe", ":lua require'otter'.export()<cr>", desc = "Quarto Export" },
            { "<leader>cqrr", ":QuartoSendAbove<cr>", desc = "Quarto Run to Cursor" },
            { "<leader>cqra", ":QuartoSendAll<cr>", desc = "Quarto Run All" },

            { "<leader>cqc", ":SlimeConfig<cr>", desc = "Quarto SlimeConfig" },

            { "<c-cr>", ":SlimeSend<cr><Down>", desc = "Send Code Line (n:next line)", silent = true },
            { "<c-cr>", "<esc>:SlimeSend<cr>a", mode = "i", desc = "Send Code Line", silent = true },
            { "<s-cr>", "<Plug>SlimeParagraphSend<cr><Up>", desc = "Send Code Paragraph", silent = true },
            {
                "<s-cr>",
                "<esc><Plug>SlimeParagraphSend<cr><Up>",
                mode = "i",
                desc = "Send Code Paragraph",
                silent = true,
            },
            { "<a-cr>", "<Plug>SlimeSendCell<cr><Up>", desc = "Send Code Cell", silent = true },
            { "<a-cr>", "<esc><Plug>SlimeSendCell<cr><Up>a", mode = "i", desc = "Send Code Cell", silent = true },

            { "<c-cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "Send Code Chunk", silent = true },
            { "<cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "Send Code Chunk", silent = true },
        },
        dependencies = {
            "jmbuhr/otter.nvim",
            dev = false,
            opts = {
                buffers = {
                    set_filetype = true,
                    write_to_disk = true,
                },
                handle_leading_whitespace = true,
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

            -- slime, tmux
            vim.g.slime_target = "tmux"
            vim.g.slime_bracketed_paste = 1
            vim.g.slime_no_mappings = 1
        end,
    },

    {
        "lukas-reineke/headlines.nvim",
        opts = function()
            local opts = {}
            for _, ft in ipairs({ "quarto", "markdown", "rmd" }) do
                opts[ft] = {
                    query = vim.treesitter.query.parse(
                        "markdown",
                        [[
                            (atx_heading [
                            (atx_h1_marker)
                            (atx_h2_marker)
                            (atx_h3_marker)
                            (atx_h4_marker)
                            (atx_h5_marker)
                            (atx_h6_marker)
                            ] @headline)

                            (thematic_break) @dash

                            (fenced_code_block) @codeblock

                            (block_quote_marker) @quote
                            (block_quote (paragraph (inline (block_continuation) @quote)))
                            (block_quote (paragraph (block_continuation) @quote))
                            (block_quote (block_continuation) @quote)
                        ]]
                    ),
                    headline_highlights = { "" },
                    fat_headline_upper_string = "",
                    fat_headline_lower_string = "",
                    bullets = {},
                    treesitter_language = "markdown",
                    -- codeblock_highlight = "CodeBlock",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = true,
                }
            end
            return opts
        end,
        ft = { "quarto", "markdown", "rmd" },
    },
}
