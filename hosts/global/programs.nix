{ config, lib, nixpkgs, pkgs, inputs, ... }:

{

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish.enable = true;
    wireshark.enable = true;
  };

}