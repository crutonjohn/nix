{ ... }:
{

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "hyprpaper &"
        ''hyprctl hyprpaper wallpaper "DP-1,~/.config/docked.jpg"''
      ];
    };
  };
}
