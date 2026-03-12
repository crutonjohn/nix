{
  # Wallpaper/Hyprpaper
  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/crutonjohn/.config/wallpaper.jpg"
      ];
      wallpaper = [
        "DP-1,~/.config/wallpaper.jpg"
        "DP-2,~/.config/wallpaper.jpg"
      ];
    };
  };
  wayland.windowManager.hyprland = {
    settings = {

      exec-once = [
        "hyprpaper &"
        ''hyprctl hyprpaper wallpaper "DP-1,~/.config/wallpaper.jpg"''
        ''hyprctl hyprpaper wallpaper "DP-2,~/.config/wallpaper.jpg"''
      ];

    };
  };
}
