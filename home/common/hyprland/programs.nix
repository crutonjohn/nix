{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    appimage-run
    bitwarden-desktop
    brightnessctl
    dmenu
    font-manager
    gnome-network-displays
    hyprpaper
    imagemagick
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    pamixer
    pavucontrol
    pixman
    pulsemixer
    sway-contrib.grimshot
    swaybg
    waybar
    wdisplays
    wineWowPackages.waylandFull
    alacritty
  ];

}
