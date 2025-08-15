{ pkgs, ... }: {

  home.packages = [
    ##################
    # Custom Scripts #
    ##################
    (pkgs.writeScriptBin "wofi-powermenu" ''
      #!/usr/bin/env bash

      entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

      selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

      case $selected in
        logout)
          loginctl kill-session $XDG_SESSION_ID;;
        suspend)
          exec systemctl suspend;;
        reboot)
          exec systemctl reboot;;
        shutdown)
          exec systemctl poweroff -i;;
      esac
    '')

  ];

  programs.fish = {
    functions = {
        nrb = ''
            set system $argv
            nixos-rebuild switch --use-remote-sudo --build-host $system --target-host $system --flake github:crutonjohn/nix#$system
        '';
        nrbu = ''
            set system $argv
            nixos-rebuild switch --use-remote-sudo --upgrade --build-host $system --target-host $system --flake github:crutonjohn/nix#$system
        '';
    };
  };

}
