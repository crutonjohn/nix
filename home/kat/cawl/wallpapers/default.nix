{
  # Wallpaper/Hyprpaper
  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/kat/.config/wallpaper.jpg"
      ];
      wallpaper = [
        "DP-1,~/.config/wallpaper.jpg"
      ];
    };
  };
}
