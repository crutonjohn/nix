{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ./generic.nix
  ];
  home.username = "bjohn";
  home.homeDirectory = "/home/bjohn";

  home.packages = with pkgs; [
    _1password-gui
  ];

}
