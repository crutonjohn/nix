hl.workspace_rule({
    workspace = "1",
    default_name = "gaming",
    monitor = "DP-2",
    persistent = true,
    decorate = false,
    no_shadow = true,
    no_rounding = true
})

hl.workspace_rule({workspace = "2", monitor = "DP-2", persistent = true})

hl.workspace_rule({workspace = "3", monitor = "DP-2"})
hl.workspace_rule({workspace = "4", monitor = "DP-2"})
hl.workspace_rule({workspace = "5", monitor = "DP-1"})
hl.workspace_rule({workspace = "6", monitor = "DP-1"})
hl.workspace_rule({workspace = "7", monitor = "DP-1"})
hl.workspace_rule({workspace = "8", monitor = "DP-1"})

hl.workspace_rule({
    workspace = "9",
    default_name = "sunshine",
    monitor = "HDMI-A-1",
    decorate = false,
    no_shadow = true,
    no_rounding = true
})
