{ pkgs, inputs, ... }: {

  imports = [
    ./generic.nix
    ./generic-linux.nix
    ./git.nix
    ./scripts
  ];

  programs.git = {
    enable = true;
    userName = "Curtis John";
    includes = [
      {
        path = "~/.config/git/gitconfig-personal";
      }
    ];
  };

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    signal-desktop
    steam
    discord
    zoom-us
    cura
    docker-compose
    lutris
    wineWowPackages.waylandFull
    remmina
    runelite
    appimage-run
    winetricks
    jdk11
    pixman
    at-spi2-atk
    mqttui
    rpi-imager

  ];

}
