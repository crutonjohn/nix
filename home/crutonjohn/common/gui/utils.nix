{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    appimage-run
    at-spi2-atk
    bitwarden-desktop
    brightnessctl
    bewcloud-client
    catimg
    font-manager
    galculator
    gimp
    helvum
    imagemagick
    lychee-slicer
    mqttui
    neofetch
    openscad
    pamixer
    pavucontrol
    pixman
    pog
    pulsemixer
    rpi-imager
    signal-desktop
    sonixd
    virt-manager
    alacritty
    easyeffects
    telegram-desktop
    vlc
  ];

}
