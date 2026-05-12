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
      enable = true;
      protonPackages = [ pkgs.proton-ge-bin ];
    };
  };

}
