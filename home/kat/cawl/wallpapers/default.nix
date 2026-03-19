{

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "hyprpaper &"
        ''hyprctl hyprpaper wallpaper "DP-1,~/.config/wallpaper.jpg"''
        ''hyprctl hyprpaper wallpaper "DP-2,~/.config/wallpaper.jpg"''
      ];
    };
  };

  # Wallpaper/Hyprpaper
  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/wallpaper.jpg"
      ];
      wallpaper = [
        "DP-1,~/.config/wallpaper.jpg"
      ];
    };
  };
}
