{ config, lib, pkgs, ... }:
{
  imports = [
    ../generic.nix
    ../generic-linux.nix
    # ../../packages/non-free.nix
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