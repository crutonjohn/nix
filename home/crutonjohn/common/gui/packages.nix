{ pkgs, ... }:
{

  home.packages = with pkgs; [
    bewcloud-client
    bitwarden-desktop
    feishin
    gimp
    hexchat
    lychee-slicer
    openscad
    signal-desktop
    telegram-desktop
    vlc
  ];

}
