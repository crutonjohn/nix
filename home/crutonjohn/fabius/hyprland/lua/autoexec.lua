--------------------
---- AUTOSTART -----
--------------------
-- Run once at session start
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl hyprpaper wallpaper 'DP-1,~/.config/wallpaper.jpg'")
    hl.exec_cmd("hyprctl hyprpaper wallpaper 'DP-2,~/.config/wallpaper.jpg'")
end)
