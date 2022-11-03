{ config, lib, pkgs, ... }:
{
  imports = [
    ./generic.nix
    ./apps/firefox
  ];
  monitors = [{
    name = "eDP-1";
    width = 5120;
    height = 1440;
    workspace = "1";
  }];
}