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
}
