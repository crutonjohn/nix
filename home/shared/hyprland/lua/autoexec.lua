--------------------
---- AUTOSTART -----
--------------------
-- Run once at session start
hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprpaper &")
end)

-- Run on every restart
hl.exec_cmd(
    "pgrep waybar >/dev/null || waybar --config ~/.config/waybar/config &")
