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

            objbr_place = "console,below",
            listmethods = true,
            specialplot = true,
            nvimpager = "split_h",
        },
    },
}
