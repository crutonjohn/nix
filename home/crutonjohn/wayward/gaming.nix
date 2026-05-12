{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}:
{

  programs = {
    lutris = {
      enable = false;
      protonPackages = [ pkgs.proton-ge-bin ];
    };
  };

}
