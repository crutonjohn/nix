{ config, lib, nixpkgs, pkgs, inputs, ... }:

{

  imports = [
    ./meta.nix
    ./programs.nix
    ./services.nix
    ./users.nix
  ];

}