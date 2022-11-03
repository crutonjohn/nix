{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ./generic.nix
  ];
  home.username = "bjohn";
  home.homeDirectory = "/home/bjohn";

  home.packages = with pkgs; [
    _1password-gui
  ];

  home.file.".xsessionrc".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$PATH
    xset r rate 200 50
    '';
}

}
