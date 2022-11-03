{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ./generic.nix
  ];
  # monitors = [{
  #   name = "eDP-1";
  #   width = 5120;
  #   height = 1440;
  #   workspace = "1";
  # }];
}