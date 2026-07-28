{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    bewcloud-client
    bitwarden-gui
    feishin
    gimp
    hexchat
    lychee-slicer
    # chitubox
    # openscad
    signal-desktop
    telegram-desktop
    vlc
    playerctl
    mpv
    inputs.subtui.packages.${pkgs.stdenv.hostPlatform.system}.subtui
    # x32edit
  ];

}
