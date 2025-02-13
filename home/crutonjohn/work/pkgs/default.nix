{ pkgs, inputs, ... }:

{

  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    blueman
    i3status-rust
    networkmanager_dmenu
    comma
    cfssl
    feh
    rofi
    pasystray
    polybar
    powertop
    zeal
    xss-lock
    psmisc
    zlib
    dmenu
    scrot
    imagemagick
    pywal
    arandr
    calc
    siji
    syncthing
    syncthing-tray
    material-icons
    nerdfonts
    pulseaudio
    gdk-pixbuf
    read-edid
    mkcert
    slack
    vault
    linode-cli
    jsonnet-bundler
    teleport_15
  ];
}
