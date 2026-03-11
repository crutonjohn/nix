{ pkgs, ... }:
{

  home.packages = with pkgs; [
    appimage-run
    bitwarden-desktop
    font-manager
    galculator
    neofetch
    networkmanager
    networkmanager_dmenu
    easyeffects
    telegram-desktop
    vlc
  ];

}
