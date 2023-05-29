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
    scrot
    imagemagick
    libnotify
    sonixd
    neofetch
    catimg
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };

  home.file.".config/wall".source = ./bg;

}
