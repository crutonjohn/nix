{ config, lib, nixpkgs, pkgs, inputs, ... }:

{

  users.defaultUserShell = pkgs.bashInteractive;

  users.users = {
    crutonjohn = {
      description = "Curtis Ray John";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "networkmanager" "docker" "dialout" "wireshark" "libvirtd" ];
      isNormalUser = true;
      home = "/home/crutonjohn";
    };
    root = {
      shell = pkgs.bashInteractive;
    };
  };

  security.sudo.extraRules = [{
    users = [ "crutonjohn" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "SETENV" "NOPASSWD" ];
    }];
  }];

}