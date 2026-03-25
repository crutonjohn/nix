{
  # Wallpaper/Hyprpaper
  home.file.".config/mobile.jpg".source = ./mobile.jpg;
  home.file.".config/docked.jpg".source = ./docked.jpg;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/crutonjohn/.config/mobile.jpg"
        "/home/crutonjohn/.config/docked.jpg"
      ];
      wallpaper = [
        "eDP-1,~/.config/mobile.jpg"
        "DP-1,~/.config/docked.jpg"
      ];
    };
  };
  wayland.windowManager.hyprland = {
    settings = {

      exec-once = [
        "hyprpaper &"
        ''hyprctl hyprpaper wallpaper "eDP-1,~/.config/mobile.jpg"''
        ''hyprctl hyprpaper wallpaper "DP-2,~/.config/docked.jpg"''
      ];

    };
  };
}
