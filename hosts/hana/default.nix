{ config, lib, nixpkgs, pkgs, ... }:

{
  imports =
    [
      ./vm-hook.nix
      ../../packages/cachix/cachix.nix
    ];
}