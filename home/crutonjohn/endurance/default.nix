{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ../generic.nix
    ./git.nix
  ];

  home.packages = with pkgs; [

    (pkgs.writeScriptBin "stm" ''
    #!/usr/bin/env bash
    nix run github:guibou/nixGL#nixGLIntel -- steam > /dev/null 2>&1 &
    '')
  ];


  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";
  # monitors = [{
  #   name = "eDP-1";
  #   width = 5120;
  #   height = 1440;
  #   workspace = "1";
  # }];

  # Blueman
  services.blueman-applet.enable = true;

  #Desktop Experience
  home.file.".config/i3/config".source = ./i3/i3.conf;
  home.file.".config/i3/ws1.json".source = ../apps/i3/ws1.json;
  home.file.".config/i3/ws2.json".source = ../apps/i3/ws2.json;
  home.file.".config/i3/ws3.json".source = ../apps/i3/ws3.json;
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
