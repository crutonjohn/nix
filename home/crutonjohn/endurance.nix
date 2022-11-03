{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ./generic.nix
  ];

  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";
  # monitors = [{
  #   name = "eDP-1";
  #   width = 5120;
  #   height = 1440;
  #   workspace = "1";
  # }];

  # Blueman
  services.blueman-applet.enable = true;
}
