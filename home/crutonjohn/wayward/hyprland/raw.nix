{ ... }:
{

  wayland.windowManager.hyprland = {
    # needed due to https://github.com/hyprwm/Hyprland/discussions/4768
    extraConfig = ''
      env = GDK_SCALE,1
      env = XCURSOR_SIZE,20
      env = SDL_VIDEODRIVER,wayland
      env = QT_QPA_PLATFORM,wayland
      env = CLUTTER_BACKEND,wayland
      env = AQ_DRM_DEVICES,/dev/dri/card1
      env = XDG_SESSION_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = NIXOS_OZONE_WL,1

      xwayland {
          force_zero_scaling   = true
          use_nearest_neighbor = true
          enabled              = true
      }

      ecosystem {
          no_update_news  = true
          no_donation_nag = true
      }

      device {
        name=ploopy-corporation-ploopy-pavonis-trackpad-touchpad
        tap-to-click=true
        sensitivity=0.5
      }
      plugin:hyprexpo {
            enabled = true
            columns = 3
            gap_size = 5
            bg_col = rgb(ffc0cb)
            workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true
            gesture_fingers = 4
            gesture_distance = 300 # how far is the "max"
            gesture_positive = false # positive = swipe down. Negative = swipe up.
      }
      plugin:csgo-vulkan-fix {
            enabled = false
            fix_mouse = true
            vkfix-app = cs2, 2560, 1440
      }
      gesture = 3, vertical, workspace
    '';
  };
}
