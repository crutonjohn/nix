{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    hyprpaper
    inputs.hypr-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.stdenv.hostPlatform.system}.hyprpicker
    waybar
    wdisplays
    wev
    wineWowPackages.waylandFull
  ];

}
