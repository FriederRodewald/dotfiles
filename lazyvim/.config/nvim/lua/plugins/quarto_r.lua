return {
    {
        "R-nvim/R.nvim",
        opts = {
            auto_start = "no",
            auto_quit = true,
            R_app = "radian",
            R_args = { "--ask-save" },
            external_term = 'tmux split-window -h -c "#{pane_current_path}"',
            config_tmux = true,

            assignment_keymap = "",
            pipe_keymap = "",

            bracketed_paste = true,
            objbr_place = "console,below",
            listmethods = true,
            specialplot = true,
            nvimpager = "split_h",
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
                enabled = false,
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
        },
        dependencies = {
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
    },
}
