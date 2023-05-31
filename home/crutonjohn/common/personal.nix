{ pkgs, inputs, ... }: {

  imports = [
    ./generic.nix
    ./generic-linux.nix
    ./git.nix
    ./scripts
  ];

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    signal-desktop
    steam
    discord
    zoom-us
    cura
    docker-compose

  ];

}
