
{ lib, pkgs, ... }:

{
  users.users.crutonjohn = {
    description = "Curtis Ray John";
    shell = pkgs.fish;
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    home = "/Users/cjohn";
  } // lib.optionalAttrs pkgs.stdenv.isLinux {
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    isNormalUser = true;
  };
}
