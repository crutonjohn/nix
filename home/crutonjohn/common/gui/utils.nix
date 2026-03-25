{ pkgs, ... }:
{

  home.packages = with pkgs; [
    appimage-run
    dmenu
    easyeffects
    font-manager
    galculator
    helvum
    networkmanager_dmenu
    pavucontrol
    pixelflasher
    pog
    pulsemixer
    rpi-imager
    virt-manager
  ];

}
