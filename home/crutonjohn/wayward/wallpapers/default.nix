{
  # Wallpaper/Hyprpaper
  home.file.".config/mobile.jpg".source = ./mobile.jpg;
  home.file.".config/docked.jpg".source = ./docked.jpg;
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "/home/crutonjohn/.config/mobile.jpg";
        }
      ];
      preload = [
        "/home/crutonjohn/.config/mobile.jpg"
        "/home/crutonjohn/.config/docked.jpg"
      ];
    };
  };
}
