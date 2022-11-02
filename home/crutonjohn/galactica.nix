{ config, lib, pkgs, ... }:
{
  imports = [
    ../common/generic.nix
    ../common/generic-linux.nix
  ];
  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";

  home.packages = with pkgs; [
    zlib
    dmenu
    arandr
    picom
    scrot
  ];

  home.file.".config/wall".source = ./space.jpg;
}