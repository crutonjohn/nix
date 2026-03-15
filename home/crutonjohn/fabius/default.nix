{ ... }:
{

  imports = [
    ../common
    ../common/gui
    ./wallpapers
    ./desktop.nix
    ./gaming.nix
    ./hyprland.nix
    # disabled for desktop, monitors never change
    # ./kanshi.nix
    ./waybar.nix
  ];

}
