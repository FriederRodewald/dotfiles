local Util = require("lazyvim.util")

return {

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
        },
        keys = {
            { "<C-Left>", "<cmd>TmuxNavigateLeft<cr>" },
            { "<C-Down>", "<cmd>TmuxNavigateDown<cr>" },
            { "<C-Up>", "<cmd>TmuxNavigateUp<cr>" },
            { "<C-Right>", "<cmd>TmuxNavigateRight<cr>" },
        },
    },

    { "nvim-neo-tree/neo-tree.nvim", enabled = false },

    {
        "folke/flash.nvim",
        opts = {
            highlight = {
                backdrop = false,
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function() end,
        },
    },

    {
        "RRethy/vim-illuminate",
        opts = {
            modes_denylist = { "v", "V" },
            min_count_to_highlight = 2,
        },
    },

    { "folke/todo-comments.nvim", enabled = false },

    {
        "nvim-telescope/telescope.nvim",
        keys = {

            -- core functions
            {
                "<leader>k",
                "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
                desc = "Switch Buffer",
            },
            { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
            -- file tree/browser
            { "<leader>t", "<cmd>Telescope file_browser<cr>", desc = "File Tree/Browser (cwd)" },
            { "<leader>T", "<cmd>Telescope file_browser path=~/<cr>", desc = "File Tree/Browser (~/)" },

            -- find
            { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
            { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
            { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
            { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
            { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
            { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
            { "<leader>fg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
            { "<leader>fG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
            { "<leader>fw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
            { "<leader>fW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
            { "<leader>fw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
            { "<leader>fW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },

            -- git
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },

            -- search
            { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
            { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            {
                "<leader>uC",
                Util.telescope("colorscheme", { enable_preview = true }),
                desc = "Colorscheme with preview",
            },
            {
                "<leader>ss",
                function()
                    require("telescope.builtin").lsp_document_symbols({
                        symbols = require("lazyvim.config").get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol",
            },
            {
                "<leader>sS",
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols({
                        symbols = require("lazyvim.config").get_kind_filter(),
                    })
                end,
                desc = "Goto Symbol (Workspace)",
            },
        },

        dependencies = {
            {
                "nvim-telescope/telescope-file-browser.nvim",
            },
        },

        opts = {
            extensions = {
                file_browser = {
                    hidden = { file_browser = true, folder_browser = false },
                    follow_symlinks = true,
                    prompt_path = true,
                },
            },
        },

        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("file_browser")
        end,
    },
}
