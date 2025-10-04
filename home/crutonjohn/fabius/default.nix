{ ... }: {

  imports = [
    ../common
    ../common/hyprland
    ../common/gui
    ./wallpapers
    ./desktop.nix
    ./gaming.nix
    ./hyprland.nix
    ./kanshi.nix
    ./waybar.nix
  ];

  # Syncthing
  services.syncthing = {
    enable = false;
    tray = { enable = true; };
  };

}
