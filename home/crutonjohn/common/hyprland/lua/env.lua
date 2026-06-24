-- Environment variables for cursor theming, keyring, and X11 app integration.
--
-- PATH is handled by UWSM via xdg.configFile."uwsm/env" in default.nix
-- (sources home-manager's hm-session-vars.sh, which includes
-- home.sessionPath additions like ~/.local/bin).
--------------------
---- ENV VARS ------
--------------------
hl.config({
    env = {
        -- System integration (gnome-keyring socket dir in the systemd user runtime)
        -- "GNOME_KEYRING_CONTROL,/run/user/1000/keyring",
        "GDK_SCALE,1", "XCURSOR_SIZE,20", "SDL_VIDEODRIVER,wayland",
        "QT_QPA_PLATFORM,wayland", "CLUTTER_BACKEND,wayland",
        "XDG_SESSION_DESKTOP,Hyprland", "XDG_SESSION_TYPE,wayland",
        "XDG_CURRENT_DESKTOP,Hyprland", "NIXOS_OZONE_WL,1",
        "HYPRCURSOR_THEME,rose-pine-hyprcursor,HYPRCURSOR_SIZE,20",
        "XCURSOR_THEME,BreezeX-RosePine-Linux,XCURSOR_SIZE,20"
    }
})
