{ config, lib, pkgs, ... }: {
  imports = [
    ./common/generic.nix
    ./common/generic-linux.nix
    ./common/git.nix
    ./common/scripts
  ];
}
