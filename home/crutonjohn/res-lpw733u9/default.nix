{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ../common/generic.nix
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

  #Desktop Experience
  home.file.".config/i3/config".source = ./i3/i3.conf;
  home.file.".config/i3/ws1.json".source = ./i3/layout/ws1.json;
  home.file.".config/i3/ws2.json".source = ./i3/layout/ws2.json;
  home.file.".config/i3/ws3.json".source = ./i3/layout/ws3.json;
  home.file.".config/i3/screen_shot.sh".source = ../apps/i3/screen_shot.sh;
  home.file.".config/i3/lockicon.png".source = ../apps/i3/lockicon.png;
  home.file.".config/picom.conf".source = ../apps/picom/picom.conf;
  home.file.".config/rofi/config.rasi".source = ../apps/rofi/config.rasi;
  home.file.".config/polybar/hack" = {
    source = ./polybar/hack;
    recursive = true;
  };
  home.file.".config/polybar/material" = {
    source = ./polybar/material;
    recursive = true;
  };
}