{ ... }: {

  imports = [
    ../common
    ../common/hyprland
    ../common/gui
    ./wallpapers
    ./desktop.nix
    ./kanshi.nix
    ./hyprland.nix
    ./waybar.nix
  ];

  # Syncthing
  services.syncthing = {
    enable = false;
    tray = { enable = true; };
  };

}
