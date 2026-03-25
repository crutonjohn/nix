{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    hyprpaper
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    waybar
    wdisplays
    wev
    wineWowPackages.waylandFull
  ];

}
