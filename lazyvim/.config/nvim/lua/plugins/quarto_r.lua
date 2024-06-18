return {
    {
        "R-nvim/R.nvim",
        opts = {
            R_app = "radian",
            external_term = 'tmux split-window -h -c "#{pane_current_path}"',
            config_tmux = true,
        },
    },
}
