{ pkgs, inputs, ... }:
{

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # needed due to https://github.com/hyprwm/Hyprland/discussions/4768
    extraConfig = ''
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
      gesture = 3, horizontal, workspace
    '';
  };

  programs = {
    fish.loginShellInit = ''
      if test (tty) = "/dev/tty1"
        exec Hyprland &> /dev/null
      end
    '';
    zsh.loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
    zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

}
