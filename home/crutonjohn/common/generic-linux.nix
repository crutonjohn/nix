{ pkgs, inputs, ... }: {

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    networkmanager_dmenu
    docker
    comma
    nfs-utils
    nerdfonts
    networkmanager
    powertop
    pavucontrol
    pulsemixer
    volctl
    zeal
    psmisc
    zlib
    dmenu
    imagemagick
    libnotify
    sonixd
    neofetch
    catimg
    font-manager
    unixtools.procps
    pamixer
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };

}