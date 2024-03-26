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

    { "R-nvim/cmp-r" },

    {
        "quarto-dev/quarto-nvim",
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
            },
        },
        ft = "quarto",
        codeRunner = {
            enabled = true,
            default_method = "slime",
        },
        keys = {
            { "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "Quarto Preview" },
            { "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "Quarto Close" },
            { "<leader>qh", ":QuartoHelp ", desc = "Quarto Help" },
            { "<leader>qe", ":lua require'otter'.export()<cr>", desc = "Quarto Export" },
            { "<leader>qrr", ":QuartoSendAbove<cr>", desc = "Quarto Run to Cursor" },
            { "<leader>qra", ":QuartoSendAll<cr>", desc = "Quarto Run All" },

            { "<leader>qc", ":SlimeConfig<cr>", desc = "Quarto SlimeConfig" },

            { "<c-cr>", ":SlimeSend<cr>", desc = "Send Code Line", silent = true },
            { "<c-cr>", "<esc>:SlimeSend<cr>a", mode = "i", desc = "Send Code Line", silent = true },
            { "<s-cr>", ":SlimeSend<cr><Down>", desc = "Send Code Line (next line)", silent = true },
            { "<s-cr>", "<esc>:SlimeSend<cr><Down>a", mode = "i", desc = "Send Code Line (next line)", silent = true },
            { "<a-cr>", "<Plug>SlimeSendCell<cr><Up>", desc = "Send Code Cell", silent = true },
            { "<a-cr>", "<esc><Plug>SlimeSendCell<cr><Up>a", mode = "i", desc = "Send Code Cell", silent = true },

            { "<c-cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "Send Code Chunk", silent = true },
            { "<cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "Send Code Chunk", silent = true },
        },
    },

    {
        "jmbuhr/otter.nvim",
        opts = {
            buffers = {
                set_filetype = true,
                write_to_disk = true,
            },
            handle_leading_whitespace = true,
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
