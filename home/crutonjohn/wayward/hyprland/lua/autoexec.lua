--------------------
---- AUTOSTART -----
--------------------
-- Run once at session start
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl hyprpaper wallpaper 'eDP-1,~/.config/mobile.jpg'")
    -- hl.exec_cmd("hyprctl hyprpaper wallpaper 'eDP-1,~/.config/docked.jpg'")
end)
