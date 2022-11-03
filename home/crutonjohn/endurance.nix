{ config, lib, pkgs, ... }:
{
  imports = [
    ./common/generic.nix
    ./common/generic-linux.nix
    ./common/scripts-linux.nix
    ./apps/firefox
  ];
  monitors = [{
    name = "eDP-1";
    width = 5120;
    height = 1440;
    workspace = "1";
  }];
}