-- Environment variables for cursor theming, keyring, and X11 app integration.
--
-- PATH is handled by UWSM via xdg.configFile."uwsm/env" in default.nix
-- (sources home-manager's hm-session-vars.sh, which includes
-- home.sessionPath additions like ~/.local/bin).
--------------------
---- ENV VARS ------
--------------------
hl.env("GDK_SCALE", "1")
hl.env("XCURSOR_SIZE", "20")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("NIXOS_OZONE_WL", "1")
hl.env("HYPRCURSOR_THEME,rose-pine-hyprcursor", "HYPRCURSOR_SIZE,20")
hl.env("XCURSOR_THEME,BreezeX-RosePine-Linux", "XCURSOR_SIZE,20")

hl.config({
    env = {
        -- System integration (gnome-keyring socket dir in the systemd user runtime)
        -- "GNOME_KEYRING_CONTROL,/run/user/1000/keyring",
    }
})
