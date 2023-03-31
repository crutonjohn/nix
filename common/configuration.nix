{ lib, pkgs, config, ... }:

let
  home-manager = import <home-manager> { inherit config; };
in

{
  imports = [
    ./home-manager.nix
    ./nix-flakes.nix
  ];

  environment.systemPackages = [ pkgs.git ];

  nix = {
    generateRegistryFromInputs = true;
    generateNixPathFromInputs = true;
    linkInputs = true;
  };

  programs.fish.enable = true;
}

