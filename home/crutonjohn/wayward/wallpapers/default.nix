{
  # Wallpaper/Hyprpaper
  home.file.".config/mobile.jpg".source = ./mobile;
  home.file.".config/docked.jpg".source = ./docked;
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
}
