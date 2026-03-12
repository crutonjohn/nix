{ config, pkgs, ... }:
{

  home.packages = [
    (pkgs.writeScriptBin "hyprland-gaming-auto-waybar-toggle" ''
      #!/usr/bin/env bash
      # Use hyprctl to watch for workspace changes
      #hyprctl dispatch focusmonitor 0  # Needed in some cases to avoid hyprctl bug

      hyprctl -j workspaces | jq -r '.[] | .id'

      socat - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
          if echo "$line" | grep -q "^workspace>>"; then
              current_ws=$(hyprctl activeworkspace -j | jq '.id')

              if [ "$current_ws" -eq 9 ]; then
                  pkill waybar
              else
                  pgrep waybar >/dev/null || waybar &
              fi
          fi
      done
    '')
  ];

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [

      ];

    };
  };
}
