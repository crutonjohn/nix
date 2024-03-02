{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ##################
    # Custom Scripts #
    ##################
    (pkgs.writeScriptBin "glsteam" ''
      #!/usr/bin/env bash
      nix run github:guibou/nixGL#nixGLIntel -- steam > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "nrbu" ''
      #!/usr/bin/env bash
      cd $HOME/Documents/nix
      sudo nixos-rebuild switch --upgrade --flake '.#wayward'
    '')

    (pkgs.writeScriptBin "nrb" ''
      #!/usr/bin/env bash
      cd $HOME/Documents/nix
      sudo nixos-rebuild switch --flake '.#wayward'
    '')

    (pkgs.writeScriptBin "wofi-powermenu" ''
      #!/usr/bin/env bash

      entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

      selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

      case $selected in
	logout)
	  swaymsg exit;;
	suspend)
	  exec systemctl suspend;;
	reboot)
	  exec systemctl reboot;;
	shutdown)
	  exec systemctl poweroff -i;;
      esac
    '')

  ];
}
