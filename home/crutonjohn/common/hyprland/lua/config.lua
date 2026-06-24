hl.config({
    general = {
        border_size = 2,
        col = {
            active_border = "rgb(ffc0cb)",
            inactive_border = "rgba(595959aa)"
        },
        gaps_in = 3,
        gaps_out = 5,
        layout = "dwindle"
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        dim_inactive = false,
        blur = {
            enabled = true,
            ignore_opacity = false,
            new_optimizations = true,
            passes = 1,
            size = 3,
            xray = true
        }
    },

    animations = {enabled = true},

    dwindle = {
        force_split = 2,
        preserve_split = true,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.0,
        use_active_for_splits = true
    },

    master = {new_on_top = true, special_scale_factor = 0.8},

    gestures = {
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = false,
        workspace_swipe_distance = 250,
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 15
    },

    input = {
        touchpad = {
            clickfinger_behavior = true,
            disable_while_typing = true,
            natural_scroll = true,
            ["tap-to-click"] = false
        },
        float_switch_override_focus = 2,
        follow_mouse = 1,
        kb_layout = "us",
        kb_options = "caps:escape",
        numlock_by_default = true,
        sensitivity = 0.0
    },

    binds = {allow_workspace_cycles = true, workspace_back_and_forth = true},

    misc = {
        always_follow_on_dnd = true,
        animate_manual_resizes = false,
        disable_autoreload = true,
        disable_hyprland_logo = true,
        enable_swallow = true,
        focus_on_activate = true,
        layers_hog_keyboard_focus = true,
        swallow_regex = ""
    },

    xwayland = {
        force_zero_scaling = true,
        use_nearest_neighbor = true,
        enabled = true
    },

    ecosystem = {no_update_news = true, no_donation_nag = true}
})
