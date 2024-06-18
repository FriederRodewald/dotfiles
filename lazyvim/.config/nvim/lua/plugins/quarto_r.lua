return {
    {
        "R-nvim/R.nvim",
        opts = {
            R_app = "radian",
            R_args = { "--ask-save" },
            external_term = 'tmux split-window -h -c "#{pane_current_path}"',
            config_tmux = true,
        },
    },
}
