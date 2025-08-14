{ config, lib, nixpkgs, pkgs, inputs, ... }:

{

  imports = [
    ./certificates.nix
    ./meta.nix
    ./programs.nix
    ./services.nix
    ./users.nix
  ];

}