--------------------
---- AUTOSTART -----
--------------------
-- Run once at session start
hl.on("hyprland.start", function()
    hl.exec_cmd(
        "/nix/store/6z538swqrmbydk8vr4v9szrfmrahaljn-dbus-1.14.10/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
    hl.exec_cmd(
        "hyprctl plugin load /nix/store/qzj9blcmljrw8ncw3i0s3ch012p69sls-hyprexpo-0.1/lib/libhyprexpo.so")
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprpaper &")
    hl.exec_cmd("hyprctl hyprpaper wallpaper 'eDP-1,~/.config/mobile.jpg'")
    hl.exec_cmd("hyprctl hyprpaper wallpaper 'DP-2,~/.config/docked.jpg'")
end)
