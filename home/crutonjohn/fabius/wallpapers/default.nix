{
  # Wallpaper/Hyprpaper
  home.file.".config/docked.jpg".source = ./docked;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/crutonjohn/.config/docked.jpg"
      ];
      wallpaper = [
        "DP-1,~/.config/docked.jpg"
      ];
    };
  };
}
