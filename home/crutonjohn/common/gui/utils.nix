{ pkgs, ... }:
{

  home.packages = with pkgs; [
    appimage-run
    dmenu
    easyeffects
    font-manager
    galculator
    crosspipe
    networkmanager_dmenu
    pavucontrol
    pixelflasher
    pog
    pulsemixer
    rpi-imager
    virt-manager
  ];

}
